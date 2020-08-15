//
//  CatalogDi.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/15/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

protocol CatalogSessionProvider {
    var session: CatalogSession { get }
}

protocol CatalogApiProvider {
    var api: CatalogApi { get }
}

protocol CatalogApiRequestProvider {
    var request: ApiRequestBuilder<CatalogSession, CatalogApi, CatalogModel> { get }
}

typealias CatalogDependencies = CatalogApiProvider & CatalogSessionProvider & CatalogApiRequestProvider

class CatalogDi: Di, CatalogDependencies {
    
    var api: CatalogApi {
        resolve(type: CatalogApi.self)!
    }
    var session: CatalogSession {
        resolve(type: CatalogSession.self)!
    }
    var request: ApiRequestBuilder<CatalogSession, CatalogApi, CatalogModel> {
        resolve(type: ApiRequestBuilder<CatalogSession, CatalogApi, CatalogModel>.self)!
    }
    
    override init() {
        super.init()
        register(type: CatalogSession.self) { _ in
            CatalogSession()
        }
        register(type: CatalogApi.self) { _ in
            CatalogApi()
        }
        register(type: ApiRequestBuilder<CatalogSession, CatalogApi, CatalogModel>.self) { di -> ApiRequestBuilder<CatalogSession, CatalogApi, CatalogModel> in
            ApiRequestBuilder(
                session: di.resolve(type: CatalogSession.self)!,
                api: di.resolve(type: CatalogApi.self)!,
                modelType: CatalogModel.self)
        }
    }
}
