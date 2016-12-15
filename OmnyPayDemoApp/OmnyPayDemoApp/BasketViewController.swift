//
//  BasketViewController.swift
//  OmnyPayDemoApp
//
//  Copyright © 2016 OmnyPay. All rights reserved.
//

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
    Helpers.makeButtonDisabled(self.btnPay)
    self.tableView.allowsSelection = false
    self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
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
    KVNProgress.showErrorWithStatus("Transaction is cancelled")
    print("cancellation received")
    self.dismissViewControllerAnimated(true, completion: {})
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
  
  /**
   * The didUpdateBasket delegate method is called when items are added in basket from Poynt
   */
  func didUpdateBasket(basket: Basket) {
    KVNProgress.dismiss()
    print("basket update received")
    if basket.state == BasketState.CompleteScan {
      Helpers.makeButtonEnabled(self.btnPay)
      return
    }
    self.cartItems = self.parseBasket(basket)
    dispatch_async(dispatch_get_main_queue()) {
      self.tableView.reloadData()
    }
  }
  
  /**
   * The didReceiveReceipt delegate method is called once payment is successful and receipt is generated for the transaction.
   */
  func didReceiveReceipt(receipt: BasketReceipt) {
    KVNProgress.dismiss()
    self.receipt = receipt
    self.performSegueWithIdentifier("receiptSegue", sender: self)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "receiptSegue" {
      let destinationVC: ReceiptViewController = segue.destinationViewController as! ReceiptViewController
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
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let count = self.cartItems.count
    if count == 0{
      let emptyLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
      emptyLabel.text = "Waiting for items"
      emptyLabel.textAlignment = NSTextAlignment.Center
      self.tableView.backgroundView = emptyLabel
      self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
      return 0
    }
    return count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCellWithIdentifier("basketLineItem") as! BasketItemTableViewCell
      let index = indexPath.row
      cell.lblItemDescription.text = self.cartItems[index].productDescription
      cell.lblItemQuantity.text = String(self.cartItems[index].productQuantity!)
      cell.lblItemCost.text = "$" + (Double(self.cartItems[index].productPrice ?? 0)/100.0).format("%03.2f")
      if self.cartItems[index].offerDescription != nil &&  self.cartItems[index].offerAmount > 0 {
        cell.lblProductOfferDescription.text = self.cartItems[index].offerDescription
        cell.lblItemDiscount.text = "-$" + (Double(self.cartItems[index].offerAmount ?? 0)/100.0).format("%03.2f")
        cell.lblItemDiscount.hidden = false
        cell.lblProductOfferDescription.hidden = false
      } else {
        cell.lblItemDiscount.hidden = true
        cell.lblProductOfferDescription.hidden = true
      }
    
    return cell
  }
  
  @IBAction func makePayment(sender: UIButton) {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    KVNProgress.showWithStatus("Payment initiated")
    /**
     * OmnyPayAPI.startPayment is used for initiating the Payment. The payment is done using
     * selected payment instrument. In this sample app,  if no payment instrument is
     * selected, then payment is done using the first payment instrument added.
     */
    OmnyPayAPI.startPayment(withPaymentInstrument: appDelegate.selectedPaymentInstrumentId!){ (basketConfirmation, error) in
      if error != nil {
        print("Unable to make payment")
        KVNProgress.showErrorWithStatus("Unable to make payment")
      }
    }
  }
  
}
