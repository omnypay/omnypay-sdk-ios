//
//  ApiWrapper.swift
//  OmnyPayDemoApp
//
//  Copyright © 2016 OmnyPay. All rights reserved.
//

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
