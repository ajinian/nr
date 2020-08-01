//
//  ViewController.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 7/31/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CatalogProvider {
    var catalog: BehaviorRelay<CatalogModel> { get }
}

class ProductCatalogController: UIViewController {
    
    typealias ViewModel = CatalogProvider & DisposeBagProvider & ErrorObservableProvider
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ViewModel?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindViews()
    }
    
    func bindViews() {
        if let viewModel = viewModel {
            viewModel.catalog.map { catalog -> [ProductModel] in
                catalog.products
            }.bind(to: tableView.rx.items(cellIdentifier: "productTableViewCell", cellType: ProductTableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element.name
                cell.imageView?.load(url: element.images.thumbnailUrl, placeholder: nil)
                    
            }.disposed(by: viewModel.disposeBag)
        }
    }
}
