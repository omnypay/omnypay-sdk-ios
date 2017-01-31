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

class ApiWrapper {
  
  static func createMerchantShopper(forMerchantId merchantId:String, username: String, password: String, completion:((([String: AnyObject])?)->Void)?){
    
    let headers = [
      "content-type": "application/json",
      "cache-control": "no-cache"
    ]
    
    let omnyPayHostURLString = Helpers.getUrl(forType: Constants.createShopper)
    let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string:omnyPayHostURLString)!,
                                                cachePolicy: .UseProtocolCachePolicy,
                                                timeoutInterval: 10.0)
    mutableURLRequest.HTTPMethod = "POST"
    mutableURLRequest.allHTTPHeaderFields = headers
    let json = ["merchant-id":merchantId, "username":username, "password":password]
    let jsonData = try! NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
    
    mutableURLRequest.HTTPBody = jsonData
    
    let session = NSURLSession.sharedSession()
    let dataTask = session.dataTaskWithRequest(mutableURLRequest, completionHandler: { (data, response, error) -> Void in
      if (error != nil) {
        print(error)
      } else {
        let httpResponse = response as? NSHTTPURLResponse
        print(httpResponse)
        
        if let sourceDictionary = Helpers.serialize(response, data: data, error: error) as? [String: AnyObject] {
          
          dispatch_async(dispatch_get_main_queue(), {
            completion?(sourceDictionary)
          })
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
    let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string:omnyPayHostURLString)!,
                                                cachePolicy: .UseProtocolCachePolicy,
                                                timeoutInterval: 10.0)
    mutableURLRequest.HTTPMethod = "POST"
    mutableURLRequest.allHTTPHeaderFields = headers
    let json = ["merchant-id":merchantId, "username":username, "password":password]
    let jsonData = try! NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
    
    mutableURLRequest.HTTPBody = jsonData
    
    let session = NSURLSession.sharedSession()
    let dataTask = session.dataTaskWithRequest(mutableURLRequest, completionHandler: { (data, response, error) -> Void in
      if (error != nil) {
        print(error)
      } else {
        let httpResponse = response as? NSHTTPURLResponse
        print(httpResponse)
        
        if let sourceDictionary = Helpers.serialize(response, data: data, error: error) as? [String: AnyObject] {
          
          dispatch_async(dispatch_get_main_queue(), {
            completion?(sourceDictionary)
          })
        }else{
          completion?(nil)
        }
      }
    })
    dataTask.resume()
  }
}
