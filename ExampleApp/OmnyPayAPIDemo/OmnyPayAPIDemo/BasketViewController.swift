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



import UIKit
import OmnyPayAPI
import KVNProgress

/**
 * This class fetches and displays all the line items or products along with the product offers.
 */
class BasketViewController: UIViewController, OmnyPayEventDelegate, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  var cartItems = [BasketItem]()
  @IBOutlet weak var btnPay: UIButton!
  var receipt: BasketReceipt?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.delegate = self
    self.tableView.dataSource = self
    Helpers.makeButtonDisabled(button: self.btnPay)
    self.tableView.allowsSelection = false
    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    OmnyPayEventListener.shared.delegate = self
    title = Constants.appTitle
    self.navigationItem.hidesBackButton = true
    self.automaticallyAdjustsScrollViewInsets = false
  }
  
  /**
   * The didCancelTransaction delegate method is called if transaction is cancelled.
   */
  func didCancelTransaction() {
    KVNProgress.configuration().minimumErrorDisplayTime = 2
    KVNProgress.showError(withStatus: "Transaction is cancelled")
    print("cancellation received")
    self.dismiss(animated: true, completion: {})
    self.navigationController?.popToRootViewController(animated: true)
  }
  
  /**
   * The didUpdateBasket delegate method is called when items are added in basket from Poynt
   */
  func didUpdateBasket(basket: Basket) {
    KVNProgress.dismiss()
    print("basket update received")
    if basket.state == BasketState.CompleteScan {
      Helpers.makeButtonEnabled(button: self.btnPay)
      return
    }
    self.cartItems = self.parseBasket(basket: basket)
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  /**
   * The didReceiveReceipt delegate method is called once payment is successful and receipt is generated for the transaction.
   */
  func didReceiveReceipt(receipt: BasketReceipt) {
    KVNProgress.dismiss()
    self.receipt = receipt
    self.performSegue(withIdentifier: "receiptSegue", sender: self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "receiptSegue" {
      let destinationVC: ReceiptViewController = segue.destination as! ReceiptViewController
      destinationVC.receipt = self.receipt
    }
  }
  
  func parseBasket(basket: Basket) -> [BasketItem] {
    var allBasketItems = [BasketItem]()
    if let basketItems = basket.items {
      for item in basketItems {
        let basketItem = BasketItem()
        basketItem.productId = item.sku
        basketItem.productDescription = item.name
        basketItem.productQuantity = item.qty!
        
        if let offers = basket.offers {
          for offer in offers {
            if basketItem.productId == offer.sku {
              basketItem.offerDescription = offer.description
              break
            }
          }
        }
        
        if let reconciledTotal = basket.reconciledTotal {
          for reconcile in reconciledTotal {
            if basketItem.productId == reconcile.sku {
              basketItem.productPrice = reconcile.total
              basketItem.offerAmount = reconcile.discountCents
              break
            }
          }
        }
        
        allBasketItems.append(basketItem)
      }
    }
    
    return allBasketItems
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let count = self.cartItems.count
    if count == 0{
      let emptyLabel = UILabel(frame: CGRect(x: 0, y:0, width:self.view.bounds.size.width, height:self.view.bounds.size.height))
      emptyLabel.text = "Waiting for items"
      emptyLabel.textAlignment = NSTextAlignment.center
      self.tableView.backgroundView = emptyLabel
      self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
      return 0
    }
    return count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "basketLineItem") as! BasketItemTableViewCell
      let index = indexPath.row
      cell.lblItemDescription.text = self.cartItems[index].productDescription
      cell.lblItemQuantity.text = String(self.cartItems[index].productQuantity!)
      cell.lblItemCost.text = "$" + (Double(self.cartItems[index].productPrice ?? 0)/100.0).format(f: "%03.2f")
      if self.cartItems[index].offerDescription != nil &&  self.cartItems[index].offerAmount! > 0 {
        cell.lblProductOfferDescription.text = self.cartItems[index].offerDescription
        cell.lblItemDiscount.text = "-$" + (Double(self.cartItems[index].offerAmount ?? 0)/100.0).format(f: "%03.2f")
        cell.lblItemDiscount.isHidden = false
        cell.lblProductOfferDescription.isHidden = false
      } else {
        cell.lblItemDiscount.isHidden = true
        cell.lblProductOfferDescription.isHidden = true
      }
    
    return cell
  }
  
  @IBAction func makePayment(_ sender: UIButton) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    KVNProgress.show(withStatus: "Payment initiated")
    /**
     * OmnyPayAPI.startPayment is used for initiating the Payment. The payment is done using
     * selected payment instrument. In this sample app,  if no payment instrument is
     * selected, then payment is done using the first payment instrument added.
     */
    OmnyPayAPI.startPayment(withPaymentInstrument: appDelegate.selectedPaymentInstrumentId!){ (basketConfirmation, error) in
      if error != nil {
        print("Unable to make payment")
        KVNProgress.showError(withStatus: "Unable to make payment")
      }
    }
  }
  
}
