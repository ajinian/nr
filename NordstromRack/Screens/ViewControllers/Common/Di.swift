//
//  DIC.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/14/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation

typealias DiFactory = (Di) -> AnyObject

protocol DiRegistarable {
    func register<Service>(type: Service.Type, factory: @escaping DiFactory)
}

protocol DiResolvable {
    func resolve<Service>(type: Service.Type) -> Service?
}

class Di: DiRegistarable, DiResolvable {
    
    var services: Dictionary<String, DiFactory>
    
    init() {
        services = Dictionary()
    }
    
    func register<Service>(type: Service.Type, factory: @escaping DiFactory) {
        services["\(type)"] = factory
    }
    
    func resolve<Service>(type: Service.Type) -> Service? {
        return services["\(type)"]?(self) as? Service
    }
}
