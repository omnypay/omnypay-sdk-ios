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
  
  // apiUrl : send the complete url for GET api call
  // completion: handler to be called
  static func httpGetMethod(headers: [String: String], apiUrl: String, completion: @escaping ([String: Any]) -> Void) {
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let url = URL(string: apiUrl)!
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    let task = session.dataTask(with: request) {
      (data, response, error) in
      if error != nil {
        print(error!.localizedDescription)
        completion(["error": "error", "message": error!.localizedDescription])
      } else {
        do {
          if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
          {
            print(json)
            completion(json)
          } else if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyObject]
          {
            print(json)
            completion(["data":json as Any])
          }
        } catch {
          print("Error in JSONSerialization; url = " + apiUrl)
          completion(["error":"error", "message": Constants.ErrorMessages.jsonSerializationError])
        }
      }
    }
    task.resume()
  }
  
  // apiUrl : send the complete url for POST api call
  // body : post parameters to send in POST request
  // headers : http headers to be sent
  // completion: handler to be called
  static func httpPostMethod(headers: [String: String], body: [String: Any], apiUrl: String, completion: @escaping ([String: Any]) -> Void) {
    let config = URLSessionConfiguration.default
    let session = URLSession(configuration: config)
    let url = URL(string: apiUrl)!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    request.allHTTPHeaderFields = headers
    
    let bodyData = try! JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
    request.httpBody = bodyData
    
    let task = session.dataTask(with: request) { (data, response, error) in
      if error != nil {
        print(error!.localizedDescription)
        completion(["error": "error", "message": error!.localizedDescription])
      } else {
        do {
          if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
          {
            print(json)
            completion(json)
          }
        } catch {
          print("Error in JSONSerialization; url = " + apiUrl)
          completion(["error":"error", "message": Constants.ErrorMessages.jsonSerializationError])
        }
      }
    }
    task.resume()
  }
  
  static func getBaseApiUrl() -> String {
    return "\(Constants.hostScheme)://\(Constants.hostUrl):\(Constants.hostPort)"
  }
  
  static func createMerchantShopper(completion: @escaping ([String: Any]) -> Void) {
    let apiUrl = getBaseApiUrl() + Constants.createShopperUrlPath
    //    let timeInMillis = String(Int64(Date().timeIntervalSince1970))
    
    let body = ["merchant-id":Constants.merchantId,
                "username":Constants.shopperUsername,
                "password":Constants.shopperPassword]
    
    //    let bodyData = try! JSONSerialization.data(withJSONObject: body, options: [])
    //    let payload = String(data: bodyData,encoding: String.Encoding.utf8)!
    
    let headers = ["content-type": "application/json",
                   "cache-control": "no-cache"]
    //    ,
    //                   "X-timestamp": timeInMillis,
    //                   "X-signature": Helpers.getSignatureForAPI(timeStamp: timeInMillis, correlationId: Constants.correlationId, requestMethod: "POST", relativePath: Constants.createShopperUrlPath, payload: payload),
    //                   "X-api-key": Constants.merchantApiKey,
    //                   "X-correlation-id": Constants.correlationId
    //                   ]
    
    httpPostMethod(headers: headers, body: body, apiUrl: apiUrl) { shopperAuthentication in
      completion(shopperAuthentication)
    }
  }
  
  static func authenticateShopperForMerchant(completion: @escaping ([String: Any]) -> Void) {
    let apiUrl = getBaseApiUrl() + Constants.authenticateMerchantShopperUrlPath
    //    let timeInMillis = String(Int64(Date().timeIntervalSince1970))
    
    let body = ["merchant-id": Constants.merchantId,
                "username": Constants.shopperUsername,
                "password": Constants.shopperPassword]
    
    //    let bodyData = try! JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
    //    let payload = String(data: bodyData,encoding: String.Encoding.utf8)!
    
    let headers = ["content-type": "application/json",
                   "cache-control": "no-cache"]
    //    ,
    //                   "X-timestamp": timeInMillis,
    //                   "X-signature": Helpers.getSignatureForAPI(timeStamp: timeInMillis, correlationId: Constants.correlationId, requestMethod: "POST", relativePath: Constants.authenticateMerchantShopperUrlPath, payload: payload),
    //                   "X-api-key": Constants.merchantApiKey,
    //                   "X-correlation-id": Constants.correlationId ]
    //
    httpPostMethod(headers: headers, body: body, apiUrl: apiUrl) { shopperAuthentication in
      completion(shopperAuthentication)
    }
  }
  
  static func getPosIdFromMerchantPos(merchantPosId: String, completion: @escaping ([String: Any]) -> Void) {
    let relativePath = Constants.getPosIdUrlPath.replacingOccurrences(of: "{merchant-id}", with: Constants.merchantId).replacingOccurrences(of: "{merchant-pos-id}", with: merchantPosId)
    let apiUrl = getBaseApiUrl() + relativePath
    let timeInMillis = String(Int64(Date().timeIntervalSince1970))
    
    let headers = ["content-type": "application/json",
                   "cache-control": "no-cache",
                   "X-timestamp": timeInMillis,
                   "X-signature": Helpers.getSignatureForAPI(timeStamp: timeInMillis, correlationId: Constants.correlationId, requestMethod: "GET", relativePath: relativePath, payload: ""),
                   "X-api-key": Constants.merchantApiKey,
                   "X-correlation-id": Constants.correlationId ]
    
    httpGetMethod(headers: headers, apiUrl: apiUrl) { posDetails in
      completion(posDetails)
    }
  }
  
}
