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
import OmnyPayIdentity

class DLScanViewController: UIViewController {

  var identityScanner: OmnyPayIdentity?
  
  @IBOutlet weak var firstName: UILabel!
  
  @IBOutlet weak var lastName: UILabel!
  
  @IBOutlet weak var errorMessage: UILabel!
  @IBOutlet weak var documentId: UILabel!
  
  @IBOutlet weak var city: UILabel!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      self.errorMessage.isHidden = true
      title = Constants.appTitle
      // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  @IBAction func startDLScan(_ sender: UIButton) {
    
    self.errorMessage.isHidden = true
    self.firstName.text = ""
    self.lastName.text = ""
    self.documentId.text = ""
    self.city.text = ""
    
    self.identityScanner!.documentDidScanHandler = {(result:IdentityResult) in
      DispatchQueue.main.async {
        guard result.error == nil else {
          self.errorMessage.text = result.error!.localizedDescription
          self.errorMessage.isHidden = false
          return
        }
        
        self.firstName.text = result.identitydocument!.firstName
        self.lastName.text = result.identitydocument!.lastName
        self.documentId.text = result.identitydocument!.idNumber
        self.city.text = result.identitydocument!.city
      }
    }
    
    self.identityScanner!.presentIdentityScanView(over: self, animated: true) { (success, error) in
      print(success, error)
    }
  }
  
  
}
