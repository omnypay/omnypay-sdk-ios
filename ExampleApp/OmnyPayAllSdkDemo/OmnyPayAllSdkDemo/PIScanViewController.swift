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
import OmnyPayPIScan

class PIScanViewController: UIViewController {
  
  var cardScanner: OmnyPayPIScan?
  
  @IBOutlet weak var cardNumber: UILabel!
  
  @IBOutlet weak var cardCVV: UILabel!

  @IBOutlet weak var cardExpiry: UILabel!
  
  @IBOutlet weak var errorMessage: UILabel!
  
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
    
  @IBAction func startPIScan(_ sender: UIButton) {
    self.errorMessage.isHidden = true
    self.cardNumber.text = ""
    self.cardCVV.text = ""
    self.cardExpiry.text = ""
    
    self.cardScanner!.cardDidScanHandler = { scanResult in
      DispatchQueue.main.async {
        guard scanResult.error == nil else {
          self.errorMessage.text = scanResult.error?.localizedDescription
          self.errorMessage.isHidden = false
          return
        }
        
        self.cardNumber.text = scanResult.piCard?.cardNumberGrouped
        self.cardCVV.text = scanResult.piCard?.cardPin
        self.cardExpiry.text = scanResult.piCard?.cardExpiryDate
      }
    }
    
    self.cardScanner!.presentCardScanView(over: self, animated: true){ data, error in
      print(data, error)
    }
  }
  
  
}
