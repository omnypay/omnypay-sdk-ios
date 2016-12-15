//
//  ReceiptItemTableViewCell.swift
//  OmnyPayDemoApp
//
//  Copyright © 2016 OmnyPay. All rights reserved.
//

import UIKit

class ReceiptItemTableViewCell: UITableViewCell {
  
  @IBOutlet weak var lblItemDescription: UILabel!
  @IBOutlet weak var lblItemQuantity: UILabel!
  @IBOutlet weak var lblOfferDescription: UILabel!
  @IBOutlet weak var lblAmount: UILabel!
  @IBOutlet weak var lblOfferDiscount: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
