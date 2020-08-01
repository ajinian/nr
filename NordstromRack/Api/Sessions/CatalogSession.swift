//
//  Network.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

class CatalogSession: SessionProtocol {
    
    var apiSession: URLSession
    
    init() {
        let config: URLSessionConfiguration = .ephemeral
        config.httpAdditionalHeaders = [
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        ]
        apiSession = URLSession(configuration: config)
    }
}
