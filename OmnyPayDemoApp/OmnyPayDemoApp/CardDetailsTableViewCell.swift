//
//  CardDetailsTableViewCell.swift
//  OmnyPayDemoApp
//
//  Copyright © 2016 OmnyPay. All rights reserved.
//

import UIKit

class CardDetailsTableViewCell: UITableViewCell {

  @IBOutlet weak var lblCardNumber: UILabel!

  @IBOutlet weak var lblCardType: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
