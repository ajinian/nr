//
//  ProductDetailViewController.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ProductProvider {
    var product: Observable<ProductModel> { get }
}

class ProductDetailViewController: UIViewController {

    typealias VM = ProductProvider & DisposeBagProvider & ErrorObservableProvider
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    var viewModel: VM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = viewModel {
            viewModel.product.subscribe(onNext: { product in
                self.imageView.load(url: product.images.thumbnailUrl, placeholder: UIImage(named: "placeholder"))
                self.nameLabel.text = product.name
                self.detailsLabel.text = "\(product.division) \(product.brand) \(product.department)"
            }).disposed(by: viewModel.disposeBag)
        }
    }
}
