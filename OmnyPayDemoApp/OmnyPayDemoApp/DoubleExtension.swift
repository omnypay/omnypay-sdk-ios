//
//  DoubleExtension.swift
//  OmnyPayDemoApp
//
//  Copyright © 2016 OmnyPay. All rights reserved.
//

import Foundation

extension Double {
  func format(f: String = "%.2f") -> String {
    //        return String(NSString(format: "%\(f)f", self))
    return String(NSString(format: f, self))
  }
}
