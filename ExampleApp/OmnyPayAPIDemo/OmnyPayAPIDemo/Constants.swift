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

/*
 * Please set merchant id, username and password
 */
struct Constants {
  static let appTitle: String = "OmnyPay"
  static let hostUrl: String = "pantheon.demo0.omnypay.net"
  static let hostPort: String = "8080"
  static let createShopper: String = "/identity/account"
  static let authenticateMerchantShopper: String = "/identity/authentication"
  static let merchantId: String = "6ec80cb8-7c45-4c40-b45d-79a7a363fbac"
  static let shopperUsername: String = "user"
  static let shopperPassword: String = "pass"
}

