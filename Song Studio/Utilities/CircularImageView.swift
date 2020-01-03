//
//  CircularImageView.swift
//  Song Studio
//
//  Created by Catherine K G on 17/11/19.
//  Copyright © 2019 Catherine. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
