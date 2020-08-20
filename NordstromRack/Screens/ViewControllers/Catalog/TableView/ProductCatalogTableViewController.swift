//
//  ViewController.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 7/31/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit
import RxSwift

class ProductCatalogTableViewController: CatalogController, ProductDetailRoute, CatalogGridRoute {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gridButton = UIBarButtonItem(image: UIImage(named: "grid"), style: .plain, target: self, action: #selector(handleGridButtonTap))
        self.navigationItem.rightBarButtonItem = gridButton
        bindViews()
    }
    
    func bindViews() {
        if let viewModel = viewModel {
            viewModel.catalog.map { catalog -> [ProductModel] in
                catalog.products
            }
            .bind(to: tableView.rx.items(cellIdentifier: "productTableViewCell", cellType: ProductTableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element.name
                let placeholder = UIImage(named: "placeholder")
                cell.imageView?.load(url: element.images.thumbnailUrl, placeholder: placeholder)
                    
            }.disposed(by: viewModel.disposeBag)
            
            tableView.rx.itemSelected
                .subscribe(onNext: { [weak self] indexPath in
                    self?.showProductDetail(viewModel: ProductDetailViewModel(index: indexPath.row, catalog: viewModel.catalog))
                }).disposed(by: viewModel.disposeBag)
        }
    }
    
    @objc func handleGridButtonTap() {
        if let viewModel = viewModel {
            showGrid(viewModel: viewModel)
        }
    }
}
