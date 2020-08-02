//
//  CatalogViewModel.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProductCatalogViewModel: ViewModel, CatalogProvider {
    var apiRequestBuilder: ApiRequestBuilder<CatalogSession, CatalogApi, CatalogModel>
    var catalog = BehaviorRelay(value: CatalogModel())
    
    override init() {
        let session = CatalogSession()
        let api = CatalogApi()
        apiRequestBuilder = ApiRequestBuilder(session: session, api: api, modelType: CatalogModel.self)
        super.init()
        apiRequestBuilder
            .build()
            .asDriver(onErrorJustReturn: CatalogModel())
            .drive(catalog)
            .disposed(by: disposeBag)
    }
}
