//
//  ProductCatalogCollectionViewController.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit

class ProductCatalogCollectionViewController: UIViewController {
    
    typealias ViewModel = CatalogProvider & DisposeBagProvider & ErrorObservableProvider
    
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        bindViews()
    }
    
    func bindViews() {
        if let viewModel = viewModel {
            viewModel.catalog.map { catalog -> [ProductModel] in
                catalog.products
            }.bind(to: collectionView.rx.items(cellIdentifier: "productCollectionViewCell", cellType: ProductCollectionViewCell.self)) { (row, element, cell) in
                cell.imageView.load(url: element.images.thumbnailUrl, placeholder: UIImage(named: "placeholder"))
                cell.titleLabel.text = element.name
            }.disposed(by: viewModel.disposeBag)
        }
    }
}

extension ProductCatalogCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewSize = collectionView.frame.size.width - 20
        return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
    }
}