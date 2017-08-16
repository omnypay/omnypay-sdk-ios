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

/*
 * Please set merchant id, username and password
 */
struct Constants {
  static let appTitle: String = "OmnyPay"
  static let hostUrl: String = "pantheon.sandbox.omnypay.net"
  static let hostPort: Int = 443
  static let hostScheme: String = "https"
  static let createShopperUrlPath: String = "/api/management/identity"
  static let authenticateMerchantShopperUrlPath: String = "/api/identity/authentication"
  static let getPosIdUrlPath: String = "/api/management/pos-terminal/merchant/{merchant-id}/merchant-pos-id/{merchant-pos-id}"
  
  static let merchantId: String = "your merchant id"
  static let shopperUsername: String = "your username"
  static let shopperPassword: String = "your password"
  static let merchantApiKey: String = "your merchant api key"
  static let merchantApiSecret: String = "your merchant secret key"
  static let correlationId: String = "your correlation id"
  
  struct ErrorMessages {
    static let jsonSerializationError = "Error in JSON serialization"
  }
}

