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
    typealias ViewModel = ProductProvider & DisposeBagProvider & ErrorObservableProvider
    func showProductDetail(viewModel: ViewModel)
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

//UIViewControllerTransitioningDelegate
//UIViewControllerAnimatedTransitioning


class FlipPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private let originFrame: CGRect
    
    init(originFrame: CGRect) {
      self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
          let toVC = transitionContext.viewController(forKey: .to),
          let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
          else {
            return
        }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        snapshot.frame = originFrame
        snapshot.layer.masksToBounds = true
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        toVC.view.isHidden = true
        
        AnimationHelper.perspectiveTransform(for: containerView)
        snapshot.layer.transform = AnimationHelper.yRotation(.pi / 2)
        
        let duration = transitionDuration(using: transitionContext)
        
        // 1
        UIView.animateKeyframes(
          withDuration: duration,
          delay: 0,
          options: .calculationModeCubic,
          animations: {
            // 2
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
              fromVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
            }
            
            // 3
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
              snapshot.layer.transform = AnimationHelper.yRotation(0.0)
            }
            
            // 4
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
              snapshot.frame = finalFrame
              snapshot.layer.cornerRadius = 0
            }
        },
          // 5
          completion: { _ in
            toVC.view.isHidden = false
            snapshot.removeFromSuperview()
            fromVC.view.layer.transform = CATransform3DIdentity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    struct AnimationHelper {
      static func yRotation(_ angle: Double) -> CATransform3D {
        return CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
      }
      
      static func perspectiveTransform(for containerView: UIView) {
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
      }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
