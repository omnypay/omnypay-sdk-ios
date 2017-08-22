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
import OmnyPayScan
import KVNProgress


/**
 * This class has a template where all the cards are displayed if user has any, or
 * user is provided with an option to add the card manually.
 */
class FetchCardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  
  @IBOutlet weak var lblSelectCard: UILabel!
  
  @IBOutlet weak var btnProceed: UIButton!
  @IBOutlet weak var tableView: UITableView!
  var cardList = [PaymentInstrumentOffer]()
  var selectedCard: Int?
  private lazy var qrScanner = OmnyPayScan.sharedInstance
  var stringQR:String?
  var refreshCardFetch = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.delegate = self
    self.tableView.dataSource = self
    title = Constants.appTitle
    if self.refreshCardFetch {
      self.fetchPaymentMethods()
      self.refreshCardFetch = false
    }
    Helpers.makeButtonDisabled(button: self.btnProceed)
    self.lblSelectCard.isHidden = false
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    if self.refreshCardFetch {
      self.fetchPaymentMethods()
      self.refreshCardFetch = false
    }
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
  }
  
  func fetchPaymentMethods() {
    KVNProgress.show(withStatus: "Getting cards for shopper")
    
    /**
     * OmnyPayAPI has a method getPaymentInstrument which can be used to get all the payment
     * instruments (credit / debit cards) which  has been added for a user account.
     * getAllPaymentInstruments methods retrieves all the cards configured.
     */
    omnypayApi.getPaymentInstruments{ (cards, error) in
      if error == nil {
        KVNProgress.dismiss()
        print(cards!.count)
        if (cards?.count)! > 0 {
          self.cardList = cards!
          DispatchQueue.main.async {
            self.tableView.reloadData()
            self.lblSelectCard.text = "Please select a card."
            self.lblSelectCard.isHidden = false
            Helpers.makeButtonDisabled(button: self.btnProceed)
          }
        } else {
          self.lblSelectCard.text = "No cards available."
          self.lblSelectCard.isHidden = false
          Helpers.makeButtonDisabled(button: self.btnProceed)
        }
      } else {
        KVNProgress.showError(withStatus: "Could not get cards for shopper")
      }
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("cardlist=" + String(self.cardList.count))
    return self.cardList.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("selected" + String(indexPath.row))
    self.selectedCard = indexPath.row
    Helpers.makeButtonEnabled(button: self.btnProceed)
    self.lblSelectCard.isHidden = true
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let tableCell = self.tableView.dequeueReusableCell(withIdentifier: "cardDetailsTableViewCell") as! CardDetailsTableViewCell
    tableCell.lblCardNumber.text = self.cardList[indexPath.row].cardNumber //"hell-hell-hell-hell"
    tableCell.lblCardType.text = self.getCardType(cardType: self.cardList[indexPath.row].cardType!)
    return tableCell
  }
  
  func getCardType(cardType: CardType) -> String {
    switch cardType {
    case .ChargeCard:
      return "Charge"
    case .Credit:
      return "Credit"
    case .Debit:
      return "Debit"
    default:
      return ""
    }
  }
  
  
  @IBAction func scanQR(_ sender: UIButton) {
    if self.selectedCard != nil {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
      appDelegate.selectedPaymentInstrumentId = self.cardList[self.selectedCard!].paymentInstrumentId
      self.scanPOSQR()
    } else {
      KVNProgress.showError(withStatus: "Please select a card")
    }
    
  }
  
  /**
   * Scan the QRCode for the Point of Sale using OmnyPayScan SDK.
   */
  func scanPOSQR(){
    
    qrScanner.didScanHandler = { [weak self] (result: ScanResult?) in
      if let result = result {
        print("Completion with result: \(String(describing: result.value)) of type \(String(describing: result.metadataType))")
        
        let qrString = result.value!
        
        self?.stringQR = qrString
        
        self?.stringQR = Helpers.extract(qrString: qrString)
        print("pos id from qrString : \(String(describing: self?.stringQR))")
        
        DispatchQueue.main.async {

          /**
           * Every OmnyPay transaction should have a basket object. The basket object is used to store
           * information about the transaction such as association with the retailer’s point of sale,
           * line items or products purchased, associated offers, loyalty points. createBasket method
           * here calls createBasket api and creates a basket. Basket is returned on successful
           * completion.
           */
          omnypayApi.createBasket { (basket, error) in
            if error == nil {
              // get pos id using merchant-id and merchant-pos-id
              ApiWrapper.getPosIdFromMerchantPos(merchantPosId: (self?.stringQR)!) { posDetails in
                if posDetails["error"] != nil {
                  KVNProgress.showError(withStatus: "Invalid QR scanned")
                  print("Could not get pos-id from merchant-pos-id")
                } else {
                  let posId = (posDetails["id"] ?? "") as! String
                  /**
                   * OmnyPayAPI has a method checkIn which associates a basket with the POS Terminal.
                   */
                  omnypayApi.checkin(onPointOfSale: posId){(success, error) in
                    if error == nil {
                      KVNProgress.dismiss()
                      print("check in successful")
                      self?.performSegue(withIdentifier: "displayBasket", sender: self)
                    } else {
                      print("unable to check in", error as Any)
                      KVNProgress.showError(withStatus: "Check in to POS failed")
                    }
                  }
                }
              }
            } else {
              KVNProgress.showError(withStatus: "Basket creation failed")
              print("Basket creation failed")
            }
          }
        }
      }
    }
    
    self.qrScanner.presentScanView(over: self, animated: true){ (success:Bool, error:NSError?) in
      if success {
        print("scanner opened successfully")
      }else{
        print("error while opening scanner: ", error?.description as Any)
      }
    }
  }
  
  @IBAction func unwindToFetchCards(_ segue: UIStoryboardSegue) {}
  
}
