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
import OmnyPayAuth
import OmnyPayIdentity
import OmnyPayPIScan

class OtherSdksViewController: UIViewController {
  
  var authenticator: OmnyPayAuth?
  var identityScanner: OmnyPayIdentity?
  var cardScanner: OmnyPayPIScan?

  override func viewDidLoad() {
      super.viewDidLoad()
    title = Constants.appTitle
      // Do any additional setup after loading the view.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
  }
  
  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
    
  @IBAction func initializePISdk(_ sender: UIButton) {
    let config = PIScanConfig(cvvRequired: true, expiryDateEditable: true, cardHolderNameEditable: true, cardNumberMaskingEnabled: true, userInfo: nil)
    
    self.cardScanner = OmnyPayPIScan(with: config)
    self.performSegue(withIdentifier: "showPIScan", sender: self)
  }

  @IBAction func initializeDLSdk(_ sender: UIButton) {
    self.identityScanner = OmnyPayIdentity.shared
    self.performSegue(withIdentifier: "showDLScan", sender: self)
  }
  
  @IBAction func initializeAuthSdk(_ sender: UIButton) {
    /*
     *  Initializing OmnyPayAuth SDK using AuthConfig
     *  reason: Reason or message why authentication is required
     *  authenticationLevel: Whether user should compulsorily be authenticated using Touch Id or user can be authenticated using Passcode as well. Here we chose to authenticate user using Touch Id if available or using Passcode.
     */
    let config = AuthConfig(reason: "Authentication Required", authenticationLevel: .BiometricOrPasscode, userInfo: nil)
    self.authenticator = OmnyPayAuth(withConfig: config)
    self.performSegue(withIdentifier: "showAuth", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showAuth" {
      let destinationVC: AuthViewController = segue.destination as! AuthViewController
      destinationVC.authenticator = self.authenticator
    } else if segue.identifier == "showDLScan" {
      let destinationVC: DLScanViewController = segue.destination as! DLScanViewController
      destinationVC.identityScanner = self.identityScanner
    } else if segue.identifier == "showPIScan" {
      let destinationVC: PIScanViewController = segue.destination as! PIScanViewController
      destinationVC.cardScanner = self.cardScanner
    }
  }

  
}




