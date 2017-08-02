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
import OmnyPayAPI

var omnypayAPI = OmnyPayAPI()

func initializeOmnyPayAPI(withMerchantId merchantId:String,
                          configuration: [String: Any?]? = nil,
                          completion: @escaping (Bool, Error?) -> Void) {
    
    
    omnypayAPI.initialize(withMerchantId: Constants.merchantId, configuration: ["host": Constants.hostScheme + "://" + Constants.hostUrl + ":" + String(Constants.hostPort), "api_key": "bd3d547dfc6adaaa43c562b455004b21", "api_secret": "40e4827157db5f7d7f31b004fb2aab36a38dcf7514721daf56dbe5e23724fca8"]){ (status, error) in
        completion(status, error)
    }
}
