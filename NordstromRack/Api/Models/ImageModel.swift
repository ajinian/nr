//
//  ImageModel.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

struct ImageModel: Codable {
    var thumbnail: String
    
    var thumbnailUrl: URL {
        URL(string: thumbnail)!
    }
}
