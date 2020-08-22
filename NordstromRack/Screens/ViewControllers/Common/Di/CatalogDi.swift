//
//  CatalogDi.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/15/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation
import RxSwift

extension Di: CatalogRequesting {
    var request: Single<CatalogModel> {
        let session = resolve(type: CatalogSession.self)
        let api = resolve(type: CatalogApi.self)
        return ApiRequestBuilder(session: session, api: api, modelType: CatalogModel.self).build()
    }
}
