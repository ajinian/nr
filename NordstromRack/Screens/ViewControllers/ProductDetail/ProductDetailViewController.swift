//
//  ProductDetailViewController.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit
import RxSwift

protocol ProductProvider {
    var product: Observable<ProductModel> { get }
    var detailsText: Observable<String?> { get }
    var nameText: Observable<String?> { get }
    var thumbnailUrl: Observable<URL?> { get }
    func thumbnailImage(url: URL) -> Observable<UIImage?>
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
            viewModel.product.subscribe(onNext: { [weak self] product in
                guard let s = self else { return }
                
                viewModel.thumbnailUrl.flatMap { url -> Observable<UIImage?> in
                    viewModel.thumbnailImage(url: url!)
                }.bind(to: s.imageView.rx.image)
                .disposed(by: viewModel.disposeBag)

                viewModel.nameText.bind(to: s.nameLabel.rx.text).disposed(by: viewModel.disposeBag)
                viewModel.detailsText.bind(to: s.detailsLabel.rx.text).disposed(by: viewModel.disposeBag)
            }).disposed(by: viewModel.disposeBag)
        }
    }
}
