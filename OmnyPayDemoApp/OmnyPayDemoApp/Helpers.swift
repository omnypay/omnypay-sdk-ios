//
//  Helpers.swift
//  OmnyPayDemoApp
//
//  Copyright © 2016 OmnyPay. All rights reserved.
//

import Foundation
import UIKit

struct Helpers {
  static func getUrl(forType url: String) -> String {
    let urlString = "http://" + Constants.hostUrl + ":" + Constants.hostPort + url
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
