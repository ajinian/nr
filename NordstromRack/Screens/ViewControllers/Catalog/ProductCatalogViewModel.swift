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
    
    var catalog = BehaviorRelay(value: CatalogModel())
    
    init(di: CatalogDependencies) {
        super.init()
        di.request
            .build()
            .asDriver(onErrorJustReturn: CatalogModel())
            .drive(catalog)
            .disposed(by: disposeBag)
    }
}
