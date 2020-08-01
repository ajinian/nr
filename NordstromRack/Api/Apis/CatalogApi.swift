//
//  CatalogApi.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

class CatalogApi: ApiProtocol {
    var resourceUrl: URL {
        return URL(string: "https://www.hautelookcdn.com/mobile-apps/Interview/catalog.json")!
    }
}
