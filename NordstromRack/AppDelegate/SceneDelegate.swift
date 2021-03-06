//
//  SceneDelegate.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 7/31/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        if let navigationController = window?.rootViewController as? UINavigationController {
            if let productCatalogController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "productCatalogCollectionViewController") as? ProductCatalogCollectionViewController {
                productCatalogController.viewModel = ProductCatalogViewModel(di: CatalogDi())
                navigationController.viewControllers = [productCatalogController]
            }
        }
    }
}

