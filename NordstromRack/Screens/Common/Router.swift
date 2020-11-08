//
//  Router.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/3/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit
import RxSwift

typealias VM = DisposeBagProvider & ErrorObservableProvider

protocol ProductDetailRoute {
    typealias ViewModel = VM & ProductProvider
    func showProductDetail(viewModel: ViewModel)
}

protocol CatalogGridRoute {
    typealias ViewModel = VM & CatalogProvider
    func showGrid(viewModel: ViewModel)
}

protocol CatalogTableRoute {
    typealias ViewModel = VM & CatalogProvider
    func showTable(viewModel: ViewModel)
}

extension ProductDetailRoute where Self: UIViewController {
    func showProductDetail(viewModel: ViewModel) {
        if let detailController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "productDetailViewController") as? ProductDetailViewController {
            detailController.viewModel = viewModel
            self.navigationController?.present(detailController, animated: true, completion: nil)
        }
    }
}

extension CatalogGridRoute where Self: UIViewController {
    func showGrid(viewModel: ViewModel) {
        if let productCatalogController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "productCatalogCollectionViewController") as? ProductCatalogCollectionViewController, let navController = self.navigationController {
            productCatalogController.viewModel = viewModel
            navController.viewControllers = [productCatalogController]
        }
    }
}

extension CatalogTableRoute  where Self: UIViewController {
    func showTable(viewModel: ViewModel) {
        if let productCatalogController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "productCatalogTableViewController") as? ProductCatalogTableViewController, let navController = self.navigationController {
            productCatalogController.viewModel = viewModel
            navController.viewControllers = [productCatalogController]
        }
    }
}
