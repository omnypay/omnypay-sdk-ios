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

class ReceiptViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var receiptItems = [BasketItem]()
  var receipt: BasketReceipt?
  
  @IBOutlet weak var itemsTableView: UITableView!
  @IBOutlet weak var lblDiscount: UILabel!
  @IBOutlet weak var lblTax: UILabel!
  @IBOutlet weak var lblSubTotal: UILabel!
  @IBOutlet weak var lblTotal: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.receiptItems = self.parseBasketForItems(receipt: self.receipt!)
    self.itemsTableView.delegate = self
    self.itemsTableView.dataSource = self
    self.itemsTableView.allowsSelection = false
    self.itemsTableView.separatorStyle = UITableViewCellSeparatorStyle.none
    title = Constants.appTitle
    self.navigationItem.hidesBackButton = true
    self.lblSubTotal.text = "$" + (Double(self.receipt!.summary?.total ?? 0)/100.0).format(f: "%03.2f")
    self.lblTax.text = "$" + (Double(self.receipt!.summary?.tax ?? 0)/100.0).format(f: "%03.2f")
    self.lblDiscount.text = "-$" + (Double(self.receipt!.summary?.discountCents ?? 0)/100.0).format(f: "%03.2f")
    self.lblTotal.text = "$" + (Double(self.receipt!.summary?.paymentTotal ?? 0)/100.0).format(f: "%03.2f")
    self.automaticallyAdjustsScrollViewInsets = false
  }
  
  func parseBasketForItems(receipt: BasketReceipt) -> [BasketItem] {
    var allBasketItems = [BasketItem]()
    if let basketItems = receipt.items {
      for item in basketItems {
        let basketItem = BasketItem()
        basketItem.productId = item.sku
        basketItem.productDescription = item.name
        basketItem.productQuantity = item.qty!
        
        if let offers = receipt.offers {
          for offer in offers {
            if basketItem.productId == offer.sku {
              basketItem.offerDescription = offer.description
              break
            }
          }
        }
        
        if let reconciledTotal = receipt.reconciledTotal {
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
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.receiptItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = self.itemsTableView.dequeueReusableCell(withIdentifier: "receiptItemCell") as! ReceiptItemTableViewCell
        let index = indexPath.row
        cell.lblItemDescription.text = self.receiptItems[index].productDescription
        cell.lblItemQuantity.text = String(self.receiptItems[index].productQuantity!)
        cell.lblAmount.text = "$" + (Double(self.receiptItems[index].productPrice ?? 0)/100.0).format(f: "%03.2f")
        if self.receiptItems[index].offerDescription != nil &&  self.receiptItems[index].offerAmount! > 0 {
          cell.lblOfferDescription.text = self.receiptItems[index].offerDescription
          cell.lblOfferDiscount.text = "-$" + (Double(self.receiptItems[index].offerAmount ?? 0)/100.0).format(f: "%03.2f")
          cell.lblOfferDiscount.isHidden = false
          cell.lblOfferDescription.isHidden = false
        } else {
          cell.lblOfferDiscount.isHidden = true
          cell.lblOfferDescription.isHidden = true
        }
      return cell
  }
  
  @IBAction func goToHome(_ sender: UIButton) {
    print("home clicked")
    self.dismiss(animated: true, completion: {})
    self.navigationController?.popToRootViewController(animated: true)
  }
  
  
  
}
