//
//  CatalogController.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/15/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CatalogProvider {
    var catalog: BehaviorRelay<CatalogModel> { get }
    var request: Single<CatalogModel> { get }
    func productTitle(at index: Int) -> Observable<String?>
    func productThumbnail(at index: Int) -> Observable<URL?>
    func productImage(at index: Int) -> Observable<UIImage?>
}

class CatalogController: UIViewController {
    typealias ViewModel = CatalogProvider & DisposeBagProvider & ErrorObservableProvider
    var viewModel: ViewModel?
}
