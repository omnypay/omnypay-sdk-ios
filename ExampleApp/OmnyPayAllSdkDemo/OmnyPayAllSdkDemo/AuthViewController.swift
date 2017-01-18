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

class AuthViewController: UIViewController {
  
  var authenticator: OmnyPayAuth?

  @IBOutlet weak var authenticationMessage: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  
  @IBAction func startAuthentication(sender: UIButton) {
    
    self.authenticator!.start { (result:AuthResult) in
      dispatch_async(dispatch_get_main_queue()) {
        if let error = result.error {
            self.authenticationMessage.text = error.nsError.localizedDescription
          return
        }

        self.authenticationMessage.text = "Authenticated Successfully"

      }
    }
  }
  
  
}
