/**
	Copyright 2017 OmnyPay Inc.

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	   http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/



import UIKit
import OmnyPayAPI
import KVNProgress

/**
 * This class initializes example app with all the prerequisites for e.g. Merchant Id and User account
 * required for the app.
 * Please set merchant id, username and password in Constants.swift file
 */
class ViewController: UIViewController {

  var merchantShopperId: String?
  var merchantAuthToken: String?
  @IBOutlet weak var btnProceed: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    btnProceed.isHidden = true
    title = Constants.appTitle
  }

  @IBAction func initializeApp(_ sender: UIButton) {

    KVNProgress.show(withStatus: "Initializing SDK")
    
    /**
     * The initializeSDK method initializes merchantId. If merchantId exists in OmnyPay system,
     * then user is created and authenticated. If not, error is returned back. Replace
     * merchantId with the your merchant_id.
     */
    omnypayApi.initialize(withMerchantId: Constants.merchantId,
                          merchantApiKey: Constants.merchantApiKey,
                          merchantApiSecret: Constants.merchantApiSecret,
                          configuration: [
                            "host": ApiWrapper.getBaseApiUrl(),
                            "correlation-id": Constants.correlationId
                            ]){ (status, error) in
      if status {
        // create merchant shopper
        ApiWrapper.createMerchantShopper() { merchantShopper in
          if merchantShopper["error"] != nil || (merchantShopper["status"] ?? "") as! String == "error" {
            print("shopper could not be created")
            KVNProgress.showError(withStatus: "Shopper could not be created")
          } else {
            /**
             * Use your identity service to authenticate the shopper. This method shows how to use OmnyPay's
             * identity service for shopper authentication.
             *
             * After authentication pass on the auth-token and shopper id to OmnyPay service.
             */
            ApiWrapper.authenticateShopperForMerchant() { shopperAuth in
              if shopperAuth["error"] != nil {
                print("shopper not authenticated with merchant")
                KVNProgress.showError(withStatus: "Invalid shopper")
              } else {
                self.merchantShopperId = shopperAuth["merchant-shopper-id"] as? String
                self.merchantAuthToken = shopperAuth["merchant-auth-token"] as? String
                DispatchQueue.main.async {
                  KVNProgress.dismiss()
                  self.btnProceed.isHidden = false
                }
              }
            }
          }
        }
      } else {
        print("Merchant initialization failed")
        KVNProgress.showError(withStatus: "Initialization failed")
      }
    }
  }

  
  @IBAction func proceedToFetchCards(_ sender: UIButton) {
    KVNProgress.show(withStatus: "Authenticating shopper")
    /**
     * This method shows how a user is authenticated with current session by passing your
     * user/shopper id and auth token. authenticateShopper is the method defined is OmnyPayAPI
     * which is responsible for authenticating a shopper with OmnyPay service.
     */
    omnypayApi.authenticateShopper(withShopperId: self.merchantShopperId!, authToken: self.merchantAuthToken!){ (session, error) in
      if error == nil {
        KVNProgress.dismiss()
        self.performSegue(withIdentifier: "fetchCards", sender: self)
      } else {
        KVNProgress.showError(withStatus: "Shopper could not be authenticated")
        print("Shopper authentication failed: ", error as Any)
      }
    }
  }

}

