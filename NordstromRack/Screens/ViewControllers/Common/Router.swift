//
//  Router.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/3/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ProductDetailRoute {
    func showProductDetail(index: Int, catalog: BehaviorRelay<CatalogModel>)
}

protocol CatalogGridRoute {
    typealias ViewModel = CatalogProvider & DisposeBagProvider & ErrorObservableProvider
    func showGrid(viewModel: ViewModel)
}

protocol CatalogTableRoute {
    typealias ViewModel = CatalogProvider & DisposeBagProvider & ErrorObservableProvider
    func showTable(viewModel: ViewModel)
}

extension ProductDetailRoute where Self: UIViewController {
    func showProductDetail(index: Int, catalog: BehaviorRelay<CatalogModel>) {
        if let detailController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "productDetailViewController") as? ProductDetailViewController {
            detailController.viewModel = ProductDetailViewModel(index: index, catalog: catalog)
            self.navigationController?.pushViewController(detailController, animated: true)
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

class TestingCustomTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let tz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let f = transitionContext.finalFrame(for: tz)
        
        let fOff = f.offsetBy(dx: f.width, dy: 55)
        tz.view.frame = fOff
        
        transitionContext.containerView.insertSubview(tz.view, aboveSubview: fz.view)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                tz.view.frame = f
        }, completion: {_ in
                transitionContext.completeTransition(true)
        })
    }
    
    
}
