//
//  CatalogApi.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

class CatalogApi: BaseApi, DiService {
    
    static var factory: FactoryClosure = { di in
        CatalogApi()
    }
    
    static func service(container: DiContainer) -> CatalogApi {
        CatalogApi()
    }
    
    override var resourceUrl: URL {
        return URL(string: "\(self.baseUrl)/catalog.json")!
    }
}
