//
//  PurchaseCategoryCell.swift
//  Song Studio
//
//  Created by Catherine K G on 17/11/19.
//  Copyright © 2019 Catherine. All rights reserved.
//

import UIKit

protocol MakePurchaseDelegate: class {
    func didPurchaseTapped()
}

class PurchaseCategoryCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var getNowButton: UIButton!
    
    weak var delegate: MakePurchaseDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.styleUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.gradientWith(topColor: UIColor.lightGray, bottomColor: UIColor.white)
    }
    private func styleUI() {
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        containerView.applyShadow()
        getNowButton.applyShadow()
        getNowButton.layer.cornerRadius = 15
        getNowButton.clipsToBounds = true
        
    }
    @IBAction func getNowtapped(_ sender: UIButton) {
        delegate?.didPurchaseTapped()
    }
}
