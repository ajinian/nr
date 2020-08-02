//
//  ProductDetailViewModel.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProductDetailViewModel: ViewModel, ProductProvider {
    
    var index: Int
    var catalog: BehaviorRelay<CatalogModel>
    var product: Observable<ProductModel> {
        catalog.map { catalog -> ProductModel in
            catalog.products[self.index]
        }
    }
    
    init(index: Int, catalog: BehaviorRelay<CatalogModel>) {
        self.index = index
        self.catalog = catalog
    }
}
