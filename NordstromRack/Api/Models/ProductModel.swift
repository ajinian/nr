//
//  ProductModel.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

struct ProductModel: Codable {
    var division: String
    var department: String
    var brand: String
    var name: String
    var images: ImageModel
}
