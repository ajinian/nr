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
    var request: Single<CatalogModel>
    
    init(di: CatalogRequesting) {
        request = di.request
        super.init()
        request
            .asDriver(onErrorJustReturn: CatalogModel())
            .drive(catalog)
            .disposed(by: disposeBag)
    }
    
    func productTitle(at index: Int) -> Observable<String?> {
        return Observable.create { [weak self] subscriber -> Disposable in
            guard let s = self else { return Disposables.create() }
            subscriber.onNext(s.catalog.value.products[index].name)
            return Disposables.create()
        }
    }
    
    func productThumbnail(at index: Int) -> Observable<URL?> {
        return Observable.create { [weak self] subscriber -> Disposable in
            guard let s = self else { return Disposables.create() }
            subscriber.onNext(s.catalog.value.products[index].images.thumbnailUrl)
            return Disposables.create()
        }
    }
    
    func productImage(at index: Int) -> Observable<UIImage?> {
        return Observable.create { [weak self] observalbe -> Disposable in
            guard let s = self else { return Disposables.create()}
            let cache = URLCache.shared
            let url = s.catalog.value.products[index].images.thumbnailUrl
            let request = URLRequest(url: url)
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                observalbe.onNext(image)
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        observalbe.onNext(image)
                    } else {
                        observalbe.onNext(UIImage(named: "placeholder"))
                    }
                }).resume()
            }
            return Disposables.create()
        }
    }
}
