//
//  BasketItemTableViewCell.swift
//  OmnyPayDemoApp
//
//  Copyright © 2016 OmnyPay. All rights reserved.
//

import UIKit

class BasketItemTableViewCell: UITableViewCell {

  @IBOutlet weak var lblItemQuantity: UILabel!
  @IBOutlet weak var lblItemDiscount: UILabel!
  @IBOutlet weak var lblItemCost: UILabel!
  @IBOutlet weak var lblProductOfferDescription: UILabel!
  @IBOutlet weak var lblItemDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
