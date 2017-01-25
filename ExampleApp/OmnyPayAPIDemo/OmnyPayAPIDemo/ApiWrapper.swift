/**
	Copyright 2016 OmnyPay Inc.

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

class ApiWrapper {
  
  static func createMerchantShopper(forMerchantId merchantId:String, username: String, password: String, completion:((([String: AnyObject])?)->Void)?){
    
    let headers = [
      "content-type": "application/json",
      "cache-control": "no-cache"
    ]
    
    let omnyPayHostURLString = Helpers.getUrl(forType: Constants.createShopper)
    var mutableURLRequest = URLRequest(url: URL(string:omnyPayHostURLString)!,
                                                cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
    mutableURLRequest.httpMethod = "POST"
    mutableURLRequest.allHTTPHeaderFields = headers
    let json = ["merchant-id":merchantId, "username":username, "password":password]
    let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    
    mutableURLRequest.httpBody = jsonData
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: mutableURLRequest, completionHandler: { (data, response, error) -> Void in
      if (error != nil) {
        print(error)
      } else {
        let httpResponse = response as? HTTPURLResponse
        print(httpResponse)
        
        if let sourceDictionary = Helpers.serialize(urlResponse: response, data: data, error: error) as? [String: AnyObject] {
          
          DispatchQueue.main.async {
            completion?(sourceDictionary)
          }
        }else{
          completion?(nil)
        }
      }
    })
    dataTask.resume()
  }
  
  static func authenticateMerchantShopper(forMerchantId merchantId:String, username: String, password: String, completion:((([String: AnyObject])?)->Void)?){
    
    let headers = [
      "content-type": "application/json",
      "cache-control": "no-cache"
    ]
    
    let omnyPayHostURLString = Helpers.getUrl(forType: Constants.authenticateMerchantShopper)
    let mutableURLRequest = NSMutableURLRequest(url: URL(string:omnyPayHostURLString)!,
                                                cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
    mutableURLRequest.httpMethod = "POST"
    mutableURLRequest.allHTTPHeaderFields = headers
    let json = ["merchant-id":merchantId, "username":username, "password":password]
    let jsonData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    
    mutableURLRequest.httpBody = jsonData
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: mutableURLRequest as URLRequest, completionHandler: { (data, response, error) -> Void in
      if (error != nil) {
        print(error)
      } else {
        let httpResponse = response as? HTTPURLResponse
        print(httpResponse)
        
        if let sourceDictionary = Helpers.serialize(urlResponse: response, data: data, error: error) as? [String: AnyObject] {
          
          DispatchQueue.main.async {
            completion?(sourceDictionary)
          }
        }else{
          completion?(nil)
        }
      }
    })
    dataTask.resume()
  }
}
