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
}

class CatalogController: UIViewController {
    typealias ViewModel = CatalogProvider & DisposeBagProvider & ErrorObservableProvider
    var viewModel: ViewModel?
}
