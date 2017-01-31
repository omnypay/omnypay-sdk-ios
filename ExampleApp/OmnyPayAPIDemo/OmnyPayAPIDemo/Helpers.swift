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



import Foundation
import UIKit

struct Helpers {
  static func getUrl(forType url: String) -> String {
    let urlString = "http://" + Constants.hostUrl + ":" + Constants.hostPort + url
    return urlString
  }
  
  static func serialize(urlResponse:URLResponse?, data:Data?, error:Error?) -> Any? {
    guard error == nil else { return nil }
    
    if let urlResponse = urlResponse as? HTTPURLResponse, urlResponse.statusCode == 204 { return NSNull() }
    
    guard let validData = data, validData.count > 0 else {
      return nil
    }
    
    do {
      let JSON = try JSONSerialization.jsonObject(with: validData as Data, options: .allowFragments)
      return JSON
    } catch {
      return nil
    }
  }
  
  static func extract(qrString:String)->String?{
    var qrString = qrString
    var index = qrString.range(of: ";", options: .backwards)
    guard index != nil else{return nil}
    
    if index!.upperBound == qrString.range(of: qrString)?.upperBound {
      qrString = qrString.substring(to: index!.lowerBound)
      index = qrString.range(of: ";", options: .backwards)
      guard index != nil else{return nil}
    }
    
    qrString = qrString.substring(to: index!.lowerBound)
    
    index = qrString.range(of: ";", options: .backwards)
    guard index != nil else{return nil}
    return qrString.substring(from: index!.upperBound)
  }
  
  static func makeButtonEnabled(button: UIButton) {
    button.isEnabled = true
    button.setTitleColor(UIColor.black, for: .normal)
  }
  
  static func makeButtonDisabled(button: UIButton) {
    button.isEnabled = false
    button.setTitleColor(UIColor.white, for: .normal)
  }
  
}
