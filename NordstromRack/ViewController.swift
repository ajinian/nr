//
//  ViewController.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 7/31/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var apiRequest: ApiRequest<CatalogSession, CatalogApi, CatalogModel>!

    override func viewDidLoad() {
        super.viewDidLoad()
        let session = CatalogSession()
        let api = CatalogApi()
        apiRequest = ApiRequest(session: session, api: api, modelType: CatalogModel.self)
        apiRequest.get()
    }


}

