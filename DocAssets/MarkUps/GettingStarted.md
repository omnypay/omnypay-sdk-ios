## Integrating with core services

There are two main classes of OmnyPayAPI SDK:

- **OmnyPayAPI**: A static class that is used to access all OmnyPay APIs.
- **OmnyPayEventListener**: A singleton class to start listening to OmnyPay events like basket updated, receipt received etc. This class expects a delegate of type `OmnyPayEventDelegate` protocol to be set. All the callbacks are delivered to this delegate.

> **Note: All OmnyPay API returns the response in associated completion blocks. These blocks are always executed on application main queue, so you can freely perform any UI task.**

### Minimum steps required

All the APIs provided by the SDK perform specific operations as described in the [OmnyPay Platform REST API Overview](https://github.com/omnypay/omnypay-platform-api/wiki/OmnyPay-Platform-REST-API). 

However there are two minimum required steps to follow before any other operation can be performed, these are:

#### 1. Initialize SDK

Initialize the OmnyPay SDK using ```initialize(withMerchantId:configuration:completion:)``` api by passing your merchant Id. The merchant_id uniquely identifies your organization and any API calls to access or update resources are scoped within the merchant id.This should be called prior to calling OmnyPay functions and recommend this be invoked at application startup. The application can detect success through the completion handler.

#### 2. Authenticate shopper

OmnyPay supports authentication through a retailer authentication service. If a retailer authentication service is used, the Retailer should work with OmnyPay technical representative to establish connection before invoking the authentication API. OmnyPay supports [basic authentication] and oAuth token in its API and SDK

To verify using oAuth, the application should pass auth token and shopper id in ```authenticateShopper(shopperId:authToken:completion:)``` api. If the oAuth token is refreshed, the application should call this API to re-authenticate the user in order to allow the shopper to continue seamlessly. These steps are necessary to make minimum validations in order to continue with any further operation.


## Anatomy of a typical transaction flow

All the APIs perform specific operations so you can design your own transaction flow and user experience.

An example flow can be created as below:

- **Initialize the SDK**

    ```swift
    import OmnyPayAPI
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // .....
    
    // Call Initialize with merchantId received as a part of registration process
    OmnyPayAPI.initialize(withMerchantId: <your mercahntId>, configuration: <[String : Any?]>) {
        (result,error) in
       
        guard error != nil else {
          print("Initialization failed.")
          return
        }
        
        /// Initialization successful.
    }
    ```
    
- **Authenticate your user with any identity service**
  
    Authenticate the user with your identity service (which can also be catered by OmnyPay). Once authenticated, pass on the Authorization token to the OmnyPay service.

- **Authenticate user (shopper) on OmnyPay platform by passing your user/shopper id and auth token**

    ```swift
    OmnyPayAPI.authenticateShopper(shopperId: "Your Shopper ID", authToken: "Your auth token") {
      (session, error) in
      
      guard error != nil else {
        print("Shopper not authenticated. Please check if auth token and shopper id is correct.")
        return
      }

      print("Shopper is successfully authenticated with OmnyPay.")
    }
    ```

- **Add a payment instrument for shopper**

    Depending on the vault configuration requested during merchant onboarding, OmnyPay SDK will connect to its own vault or a third party vault including that of a retailer.

    ```swift
    let provisionCardParam = ProvisionCardParam()
    provisionCardParam.cardNumber = "1234567812345678"
    provisionCardParam.cardAlias("mycard");
    provisionCardParam.cardType = CardType.Debit
    provisionCardParam.cardIssuer = "Thomas cook"
    provisionCardParam.cardHolderZip = "90211"
    provisionCardParam.cardExpiryDate = "12/2020"
    provisionCardParam.cardHolderName = "Jane Wilson"

    OmnyPayAPI.provision(paymentInstrument: provisionCardParam) {
      (paymentInstrumentInfo, error) in
      guard error != nil else {
        print("Payment instrument could not be added.")
        return
      }
      
      print("Payment instrument added successfully.")
    }
    ```

- **Create a basket**

    Every OmnyPay transaction should have a basket object. The basket object is used to store information about the transaction such as association with the retailer’s point of sale, lineitems or products purchased, associated offers, loyalty points, etc. 

    ```swift
    OmnyPayAPI.createBasket() { (basket,error) in
      guard error != nil else {
        print("Basket could not be created.")
        return
      }
      
      print("Basket successfully.")
    }
    ```

- **Scan the Point of Sale QRCode**

    Scan the QRCode flashed on the Point of Sale using **OmnyPayScan SDK**.

    ```swift
    import UIKit
    import OmnyPayScan

    class ViewController: UIViewController {

      private lazy var omnyPayScanner: OmnyPayScan? = OmnyPayScan.sharedInstance
      private var posId: String?

      @IBAction func presentScanView(sender: UIButton) {

        let didDismissHandler = {
          print("OmnyPay scan view did dismiss")
        }

        let didScanHandler = { [weak self] (result: ScanResult?) in
          if let result = result {
            print("Completion with result: \(result.value) of type \(result.metadataType)")
            self?.posId = result.value
          }
          self?.omnyPayScanner?.dismissScanView(true, completion: didDismissHandler)
        }

        omnyPayScanner?.didScanHandler = didScanHandler
        omnyPayScanner?.presentScanView(over: self, animated: true){ 
          (success:Bool, error:NSError?) in
          if success {
            print("success")
          } else {
            print(error?.description)
          }
        }
      }
    }
    ```

- **Checkin basket on Point of sale terminal**

    Register a Checkin of the shopper at the Point of Sale through a scan of a QR code or a beacon. Either way the application should pass the Point of Sale(POS) Id mapped to the QR code.

    **Prerequisite:** 
    - AutenticatedShopper

    ```swift
    OmnyPayAPI.checkin(onPointOfSale: "posId") { (result, error) in
      guard error != nil else {
        print("Checkin failed.")
        return
      }
      
      print("Checkin successful.")
      
      /// Set the delegate of OmnyPayEventListener and start listening to events
      OmnyPayEventListener.shared.delegate = self // (implementing `OmnyPayEventDelegate`)
    }
    ```
  
- **POS adds items in the basket.**

    Application will be notified of line items that have been added by a sales executive at the Point of Sale. App should listen to `didUpdateBasket(basket:)` callback for this purpose.

    **Prerequisite:** 
    - AutenticatedShopper 
    - Basket created
    - Successful Check-in
    
    ```swift
    class EventListener: OmnyPayEventDelegate {
      func didUpdateBasket(basket: Basket) {
        /// Updated basket received. Extract properties and show in UI.
      }
    }
    ```

- **Preview basket for selected payment instrument**

    Preview the projected itemized payment for the payment instrument selected. The basket will contain:
    - Itemized product with associated offer discounts in the basket
    - Card linked offer discounts
    - Eligible loyalty points redeemed
    - Subtotal, tax and total amounts
    

    **Prerequisite:**
    - AutenticatedShopper
    - Basket Created 
    - Successful Check-in
    - Basket with a non-zero subtotal value
    - Optional – Loyalty points redemption selected
    - Optional – Coupons or Offers selected

    ```swift
    OmnyPayAPI.preview(forPaymentInstrument: "paymentInstrumentId") {
      (basketPreview,error) in
      guard error != nil else {
        print("Preview not available.")
        return
      }
      
      if let basketPreview = basketPreview {
        /// Extract basket and show it on UI.
      }
    }
    ```

- **Start the payment**

    Pay the retail transaction using the payment instrument selected by the shopper.

    **Prerequisite:** 
    - AutenticatedShopper 
    - Basket Created 
    - Sucessful CheckIn
    - Basket with a non-zero subtotal value.
    - Optional – Loyalty points redemption selected.
    - Optional – Coupons or Offers selected
    - Optional – PreviewPayment done to estimate taxes, card linked offers 

    ```swift
    OmnyPayAPI.startPayment(withPaymentInstrument: "paymentInstrumentId") {
      (basketPaymentConfirmation,error) in
      
      guard error != nil else {
        print("Payment failed.")
        return
      }
      
      /// Payment successful.
    }
    ```

- **Get payment receipt**

  Fetches the payment receipt for the current transaction.
  
  **Prerequisite:**
  - AutenticatedShopper
  - Basket Created
  - Sucessful CheckIn
  - Basket with a non-zero subtotal value.

  ```swift
    OmnyPayAPI.getPaymentReceipt() { (paymentReceipt,error) in 
    
      guard error != nil else {
          print("Could not get payment receipt.")
          return
      }
      
      /// Extract properties and show on UI.
    }
  ```



## Using supporting OmnyPay frameworks
### OmnyPayAuth
This framework is for authenticating user with device using Touch Id or device Passcode. To use this in your app, just add **OmnyPayAuth** framework as embedded framework.

```swift
    let config = AuthConfig(reason: "Authentication Required", authenticationLevel: .BiometricOrPasscode, userInfo: nil)
    
    let authenticator = OmnyPayAuth(withConfig: config)
    
    authenticator.start{ (result:AuthResult) in
        if let error = result.error {
            print("Authentication failed: ", error.nsError.localizedDescription)
        } else {
            print("Authentication successful")
        }
    }
```

### OmnyPayPIScan
This framework helps in retrieving credit / debit card or payment instrument information from device camera scan. To use this framework in your app, just add **OmnyPayPIScan** framework as embedded framework.

```swift
    let config = PIScanConfig(cvvRequired: true, expiryDateEditable: true, cardHolderNameEditable: true, cardNumberMaskingEnabled: true, userInfo: nil)
    
    let cardScanner = OmnyPayPIScan(with: config)
    
    cardScanner.cardDidScanHandler = { scanResult in
        guard scanResult.error == nil else {
          print("Scan failed: ", scanResult.error?.localizedDescription)
          return
        }
        
        let cardNumber = scanResult.piCard?.cardNumberGrouped
        ...
    }
    
    cardScanner.presentCardScanView(over: self, animated: true){ status, error in
      ...
    }
```

### OmnyPayIdentity
This framework helps in retrieving Driving licence information from device camera using scan. To use this framework just add **OmnyPayIdentity** framework as embedded framework.

```swift
    let identityScanner = OmnyPayIdentity.shared
    identityScanner.documentDidScanHandler = {(result:IdentityResult) in
        guard result.error == nil else {
          print("Scan failed: ", result.error!.localizedDescription)
          return
        }
        
        let firstName = result.identitydocument!.firstName
        ...
    }
    
    identityScanner.presentIdentityScanView(over: self, animated: true) { (status, error) in
      ...
    }
```
