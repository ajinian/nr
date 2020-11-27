//
//  ProductCatalogCollectionViewController.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit

class ProductCatalogCollectionViewController: CatalogController, CatalogTableRoute, ProductDetailRoute {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        let listButton = UIBarButtonItem(image: UIImage(named: "list"), style: .plain, target: self, action: #selector(showList))
        self.navigationItem.rightBarButtonItem = listButton
        bindViews()
    }
    
    func bindViews() {
        if let viewModel = viewModel {
            viewModel.catalog.map { catalog -> [ProductModel] in
                catalog.products
            }.bind(to: collectionView.rx.items(cellIdentifier: "productCollectionViewCell", cellType: ProductCollectionViewCell.self)) { (row, element, cell) in
                viewModel.productTitle(at: row).bind(to: cell.titleLabel.rx.text).disposed(by: viewModel.disposeBag)
                viewModel.productImage(at: row).bind(to: cell.imageView.rx.image).disposed(by: viewModel.disposeBag)
            }.disposed(by: viewModel.disposeBag)
            
            collectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
                self?.showProductDetail(viewModel: ProductDetailViewModel(index: indexPath.row, catalog: viewModel.catalog))
            }).disposed(by: viewModel.disposeBag)
        }
    }
    
    @objc func showList() {
        if let viewModel = viewModel {
            showTable(viewModel: viewModel)
        }
    }
}

extension ProductCatalogCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width - 20
        return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
    }
}
