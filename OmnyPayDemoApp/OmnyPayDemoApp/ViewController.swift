//
//  ViewController.swift
//  OmnyPayDemoApp
//
//  Copyright © 2016 OmnyPay. All rights reserved.
//

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
    btnProceed.hidden = true
    title = Constants.appTitle
  }

  @IBAction func initializeApp(sender: UIButton) {

    KVNProgress.showWithStatus("Initializing SDK")
    
    /**
     * The initializeSDK method initializes merchantId. If merchantId exists in OmnyPay system,
     * then user is created and authenticated. If not, error is returned back. Replace
     * merchantId with the your merchant_id.
     */
    OmnyPayAPI.initialize(withMerchantId: Constants.merchantId, configuration: ["host":Constants.hostUrl]){ (status, error) in
      if status {
        
        ApiWrapper.createMerchantShopper(forMerchantId: Constants.merchantId, username: Constants.shopperUsername, password: Constants.shopperPassword) { data in
        
          if data?["error"] != nil {
            print("shopper could not be created")
            KVNProgress.showErrorWithStatus("Shopper could not be created")
          } else {
          
            /**
             * Use your identity service to authenticate the shopper. This method shows how to use OmnyPay's
             * identity service for shopper authentication.
             * <p></p>
             * After authentication pass on the auth-token and shopper id to OmnyPay service.
             */
            ApiWrapper.authenticateMerchantShopper(forMerchantId: Constants.merchantId, username: Constants.shopperUsername, password: Constants.shopperPassword){ data in
              if data?["error"] != nil {
                print("shopper not authenticated with merchant")
                KVNProgress.showErrorWithStatus("Invalid shopper")
              } else {
                self.merchantShopperId = data?["merchant-shopper-id"] as? String
                self.merchantAuthToken = data?["merchant-auth-token"] as? String
                KVNProgress.dismiss()
                self.btnProceed.hidden = false
              }
            }
          }
        }
      } else {
        print("Merchant initialization failed")
        KVNProgress.showErrorWithStatus("Initialization failed")
      }
    }
  }

  
  @IBAction func proceedToFetchCards(sender: UIButton) {
    
    /**
     * This method shows how a user is authenticated with current session by passing your
     * user/shopper id and auth token. authenticateShopper is the method defined is OmnyPayAPI
     * which is responsible for authenticating a shopper with OmnyPay service.
     */
    OmnyPayAPI.authenticateShopper(shopperId: self.merchantShopperId!, authToken: self.merchantAuthToken!){ (session, error) in
      if error == nil {
        self.performSegueWithIdentifier("fetchCards", sender: self)
      } else {
        print("Shopper could not be authenticated")
      }
    }
  }

}

