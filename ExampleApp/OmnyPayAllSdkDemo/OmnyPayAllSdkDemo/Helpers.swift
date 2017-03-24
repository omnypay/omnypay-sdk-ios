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
    var urlString: String = Constants.hostScheme
    urlString = urlString + "://"
    urlString = urlString + Constants.hostUrl
    urlString = urlString + ":"
    urlString = urlString + String(Constants.hostPort)
    urlString = urlString + url
    return urlString
  }
  
  static func serialize(urlResponse:NSURLResponse?, data:NSData?, error:NSError?) -> AnyObject? {
    guard error == nil else { return nil }
    
    if let urlResponse = urlResponse as? NSHTTPURLResponse where urlResponse.statusCode == 204 { return NSNull() }
    
    guard let validData = data where validData.length > 0 else {
      return nil
    }
    
    do {
      let JSON = try NSJSONSerialization.JSONObjectWithData(validData, options: .AllowFragments)
      return JSON
    } catch {
      return nil
    }
  }
  
  static func extract(qrString:String)->String?{
    var qrString = qrString
    var index = qrString.rangeOfString(";", options: .BackwardsSearch)
    guard index != nil else{return nil}
    
    if index!.endIndex == qrString.rangeOfString(qrString)?.endIndex {
      qrString = qrString.substringToIndex(index!.startIndex)
      index = qrString.rangeOfString(";", options: .BackwardsSearch)
      guard index != nil else{return nil}
    }
    
    qrString = qrString.substringToIndex(index!.startIndex)
    
    index = qrString.rangeOfString(";", options: .BackwardsSearch)
    guard index != nil else{return nil}
    return qrString.substringFromIndex(index!.endIndex)
  }
  
  static func makeButtonEnabled(button: UIButton) {
    button.enabled = true
    button.setTitleColor(UIColor.blackColor(), forState: .Normal)
  }
  
  static func makeButtonDisabled(button: UIButton) {
    button.enabled = false
    button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
  }
  
}
