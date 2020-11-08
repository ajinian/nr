//
//  CatalogDi.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/15/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation
import RxSwift

protocol CatalogRequesting {
    var request: Single<CatalogModel> { get }
}

class CatalogDi: Di {
    override init() {
        super.init()
        register(type: CatalogSession.self) { _ in
            CatalogSession()
        }
        register(type: CatalogApi.self) { _ in
            CatalogApi()
        }
    }
}

extension CatalogDi: CatalogRequesting {
    var request: Single<CatalogModel> {
        let session = resolve(type: CatalogSession.self)!
        let api = resolve(type: CatalogApi.self)!
        return ApiRequestBuilder(session: session, api: api, modelType: CatalogModel.self).build()
    }
}
