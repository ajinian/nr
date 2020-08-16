//
//  CatalogDi.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/15/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

class CatalogDi: DiContainer {
    
    var session: CatalogSession {
        resolve(type: CatalogSession.self)
    }
    
    var api: CatalogApi {
        resolve(type: CatalogApi.self)
    }
    
    var request: ApiRequestBuilder<CatalogSession, CatalogApi, CatalogModel> {
        ApiRequestBuilder(session: session, api: api, modelType: CatalogModel.self)
    }
}
