//
//  DIC.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/14/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation
import RxSwift

typealias FactoryClosure = (DiContainer) -> AnyObject
protocol DiService {
    static var factory: FactoryClosure { get }
}

protocol DiContainer {
    func resolve<Service>(type: Service.Type) -> Service where Service: DiService
}

extension DiContainer {
    func resolve<Service>(type: Service.Type) -> Service where Service: DiService {
        type.factory(self) as! Service
    }
}

protocol CatalogRequesting {
    var request: Single<CatalogModel> { get }
}

class Di: DiContainer {}
