//
//  ReceiptSummaryTableViewCell.swift
//  OmnyPayDemoApp
//
//  Copyright © 2016 OmnyPay. All rights reserved.
//

import UIKit

class ReceiptSummaryTableViewCell: UITableViewCell {
  
  @IBOutlet weak var lblDescription: UILabel!
  
  @IBOutlet weak var lblAmount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
