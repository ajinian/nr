//
//  BaseApi.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/2/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

class BaseApi: ApiProtocol {
    var baseUrl = "https://www.hautelookcdn.com/mobile-apps/Interview"
    var resourceUrl: URL {
        URL(string: baseUrl)!
    }
}
