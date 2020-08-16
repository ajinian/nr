//
//  DIC.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/14/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

protocol DiService {
    associatedtype Service
    static func service(container: DiContainer) -> Service
}

protocol DiContainer {
    func resolve<Service>(type: Service.Type) -> Service.Service where Service: DiService
}

extension DiContainer {
    func resolve<Service>(type: Service.Type) -> Service.Service where Service: DiService {
        type.service(container: self)
    }
}
