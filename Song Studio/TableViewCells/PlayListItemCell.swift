//
//  PlayListItemCell.swift
//  Song Studio
//
//  Created by Catherine K G on 17/11/19.
//  Copyright © 2019 Catherine. All rights reserved.
//

import UIKit
import Kingfisher

class PlayListItemCell: UITableViewCell {
    
    //MARK: Cell Outlets
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var playListNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var coverImageUrl: String = "" {
        didSet {
            coverImageView.kf.setImage(with: URL(string: coverImageUrl))
        }
    }
    
    var playListName: String = "" {
        didSet {
            playListNameLabel.text = playListName
        }
    }
    
    var artistName: String = "" {
        didSet {
            artistNameLabel.text = artistName
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
