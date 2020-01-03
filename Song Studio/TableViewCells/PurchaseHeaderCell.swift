//
//  PurchaseHeaderCell.swift
//  Song Studio
//
//  Created by Catherine K G on 17/11/19.
//  Copyright © 2019 Catherine. All rights reserved.
//

import UIKit

class PurchaseHeaderCell: UITableViewCell {

    @IBOutlet weak var goPremiumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleUI()
    }
    
    private func styleUI() {
        goPremiumLabel.layer.cornerRadius = 12
        goPremiumLabel.clipsToBounds = true
    }

}
