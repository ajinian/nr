//
//  Network.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

class CatalogSession: SessionProtocol, DiService {
    
    typealias Service = CatalogSession
    static func service(container: DiContainer) -> CatalogSession {
        CatalogSession()
    }
    
    var apiSession: URLSession
    
    init() {
        let config: URLSessionConfiguration = .default
        config.httpAdditionalHeaders = [
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        ]
        apiSession = URLSession(configuration: config)
    }
}
