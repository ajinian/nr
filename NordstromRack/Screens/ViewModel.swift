//
//  ViewModel.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    
    let disposeBag = DisposeBag()
    let error = PublishRelay<Error>()
    var apiRequestBuilder: ApiRequestBuilder<CatalogSession, CatalogApi, CatalogModel>
    var catalog = BehaviorRelay(value: CatalogModel())
    
    init() {
        let session = CatalogSession()
        let api = CatalogApi()
        apiRequestBuilder = ApiRequestBuilder(session: session, api: api, modelType: CatalogModel.self)
        apiRequestBuilder
            .build()
            .asDriver(onErrorJustReturn: CatalogModel())
            .drive(catalog)
            .disposed(by: disposeBag)
    }
}
