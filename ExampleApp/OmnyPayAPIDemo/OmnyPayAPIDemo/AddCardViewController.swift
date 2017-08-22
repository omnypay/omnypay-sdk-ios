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



import UIKit
import OmnyPayAPI
import KVNProgress

/**
 * The AddCardViewController class has a template where user is provided with an option to add the card
 * manually using 'add' button.
 */
class AddCardViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UITextFieldDelegate {
  
  @IBOutlet weak var tfCardNumber: UITextField!
  
  @IBOutlet weak var tfCardAlias: UITextField!
  
  @IBOutlet weak var tfCardIssuer: UITextField!
  
  @IBOutlet weak var tfCardExpiry: UITextField!
  
  @IBOutlet weak var tfZip: UITextField!
  
  @IBOutlet weak var tfHolderName: UITextField!
  
  @IBOutlet weak var pickerCardType: UIPickerView!
  
  var pickerValueIndex: Int = 0
  
  let cardTypePickerDataSource = ["Credit", "Charge-Card", "Debit"]
  var newCardAdded = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = Constants.appTitle
    self.pickerCardType.delegate = self
    self.pickerCardType.dataSource = self
    navigationController?.delegate = self
    self.tfZip.delegate = self
    self.tfHolderName.delegate = self
    self.tfCardExpiry.delegate = self
    self.tfCardIssuer.delegate = self
    self.tfCardAlias.delegate = self
    self.tfCardNumber.delegate = self
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddCardViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    if let previousController = viewController as? FetchCardsViewController {
      if self.newCardAdded {
        previousController.refreshCardFetch = true
      }
    }
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return self.cardTypePickerDataSource.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return self.cardTypePickerDataSource[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.pickerValueIndex = row
  }
  
  @IBAction func addCard(_ sender: UIButton) {
    
    let validationMessage = self.allFieldsEntered()
    if validationMessage != nil {
      KVNProgress.configuration().minimumErrorDisplayTime = 2
      KVNProgress.showError(withStatus: validationMessage)
      return
    }
    
    KVNProgress.show(withStatus: "Adding your card")
    
    let card = ProvisionCardParam()
    card.cardAlias = self.tfCardAlias.text
    card.cardExpiryDate = self.tfCardExpiry.text
    card.cardHolderName = self.tfHolderName.text
    card.cardHolderZip = self.tfZip.text
    card.cardIssuer = self.tfCardIssuer.text
    card.cardNumber = self.tfCardNumber.text
    card.cardType = self.getCardTypeFromPickerValue()
    
    /**
     * OmnyPayAPI has a method provision which can be used for provisioning of cards.
     * Cards can be of the following types: credit, debit, charge-card, gift-card. Depending on the vault
     * configuration requested during merchant onboarding, OmnyPay SDK will connect to its own vault or
     * a third party vault including that of a retailer.
     */
    omnypayApi.provision(paymentInstrument: card) { (paymentInstrumentInfo, error) in
      if error == nil {
        KVNProgress.dismiss()
        self.newCardAdded = true
        self.performSegue(withIdentifier: "returnToFetchCards", sender: self)
      } else {
        KVNProgress.showError(withStatus: "Card could not be added")
        print("card addition error: ", error ?? "couldn't fetch error")
      }
    }
  }
  
  func allFieldsEntered() -> String? {
    var message: String? = nil
    if self.tfCardNumber.text!.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty {
      message = "Please enter card number"
    } else if self.tfCardAlias.text!.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty {
      message = "Please enter card alias"
    } else if self.tfCardIssuer.text!.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty {
      message = "Please enter card issuer"
    } else if self.tfCardExpiry.text!.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty {
      message = "Please enter card expiry date"
    } else if self.tfZip.text!.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty {
      message = "Please enter card holder zip"
    } else if self.tfHolderName.text!.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty {
      message = "Please enter card holder name"
    }
    return message
  }
  
  func getCardTypeFromPickerValue() -> CardType {
    switch self.cardTypePickerDataSource[self.pickerValueIndex] {
      case "Credit":
        return CardType.Credit
      case "Charge-Card":
        return CardType.ChargeCard
      case "Debit":
        return CardType.Debit
      default:
        return CardType.Credit
    }
  }
  
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == self.tfCardNumber {
      self.tfCardAlias.becomeFirstResponder()
    } else if textField == self.tfCardAlias {
      self.tfCardIssuer.becomeFirstResponder()
    } else if textField == self.tfCardIssuer {
      self.tfCardExpiry.becomeFirstResponder()
    } else if textField == self.tfCardExpiry {
      self.tfZip.becomeFirstResponder()
    } else if textField == self.tfZip {
      self.tfHolderName.becomeFirstResponder()
    } else if textField == self.tfHolderName {
      self.tfHolderName.resignFirstResponder()
    }
    return true
  }

  func dismissKeyboard()  {
    self.view.endEditing(true)
  }
  
}

