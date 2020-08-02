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

class ProductCatalogTableViewController: UIViewController {
    
    typealias ViewModel = CatalogProvider & DisposeBagProvider & ErrorObservableProvider
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                .subscribe(onNext: { indexPath in
                    if let detailController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "productDetailViewController") as? ProductDetailViewController {
                        self.navigationController?.pushViewController(detailController, animated: true)
                    }
                }).disposed(by: viewModel.disposeBag)
        }
    }
}
