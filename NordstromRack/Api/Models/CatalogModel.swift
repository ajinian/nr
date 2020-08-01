//
//  CatalogModel.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

struct CatalogModel: Codable {
    var products: [ProductModel]
    init() {
        products = []
    }
}
