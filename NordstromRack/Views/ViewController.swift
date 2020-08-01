//
//  ViewController.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 7/31/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UITableViewController {
    
    var apiRequestBuilder: ApiRequestBuilder<CatalogSession, CatalogApi, CatalogModel>!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        let session = CatalogSession()
        let api = CatalogApi()
        apiRequestBuilder = ApiRequestBuilder(session: session, api: api, modelType: CatalogModel.self)
        apiRequestBuilder
            .build()
            .subscribe { event in
                switch event {
                    case .success(let model):
                        print("model: ", model)
                    case .error(let error):
                        print("Error: ", error)
                }
        }.disposed(by: disposeBag)
    }


}

