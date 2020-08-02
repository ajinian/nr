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
    func productAt(index: Int) -> Observable<ProductModel>
}

class ProductDetailViewController: UIViewController {

    typealias VM = DisposeBagProvider & ErrorObservableProvider
    
    @IBOutlet weak var imageView: UIImageView!
    var viewModel: VM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = viewModel {
            
        }
    }
}
