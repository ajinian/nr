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
    var nameText: Observable<String?> {
        catalog.map { catalog -> String? in
            let product = catalog.products[self.index]
            return product.name
        }
    }
    
    var detailsText: Observable<String?> {
        catalog.map { catalog -> String? in
            let product = catalog.products[self.index]
            return "\(product.division) \(product.brand) \(product.department)"
        }
    }
    
    var thumbnailUrl: Observable<URL?> {
        catalog.map { catalog -> URL? in
            let product = catalog.products[self.index]
            return product.images.thumbnailUrl
        }
    }
    
    func thumbnailImage(url: URL) -> Observable<UIImage?> {
        return Observable.create { observalbe -> Disposable in
            let cache = URLCache.shared
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    observalbe.onNext(image)
                } else {
                    observalbe.onNext(UIImage(named: "placeholder"))
                }
            })
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                observalbe.onNext(image)
            } else {
                task.resume()
            }
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    
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
