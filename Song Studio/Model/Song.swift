//
//  Song.swift
//  Song Studio
//
//  Created by Catherine K G on 17/11/19.
//  Copyright © 2019 Catherine. All rights reserved.
//

import Foundation

struct Song: Decodable {
    
    var song: String
    var url: String
    var artists: String
    var coverImage: String
    
    private enum CodingKeys: String, CodingKey {
        case song
        case url
        case artists
        case coverImage = "cover_image"
    }
}

