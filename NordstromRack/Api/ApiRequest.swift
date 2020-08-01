//
//  Request.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation
import RxSwift

class ApiRequest <S: SessionProtocol, A: ApiProtocol, C: Codable> {
    
    private let session: S
    private let api: A
    private let modelType: C.Type
    
    init(session: S, api: A, modelType: C.Type) {
        self.session = session
        self.api = api
        self.modelType = modelType
    }
    
    func get() {
        let request = URLRequest(url: api.resourceUrl)
        let task = session.apiSession.dataTask(with: request) { [weak self] (data, response, error) in
            guard let _self = self else {
                print("Self is nil")
                return
            }
            guard error == nil else {
                // TODO: Handle session error
                print(error!)
                return
            }
            guard let response = response as? HTTPURLResponse, (200...399).contains(response.statusCode) else {
                // TODO: Handle network error
                print("API response error")
                return
            }
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(_self.modelType, from: data!)
                print(model)
            } catch {
                // TODO: Handle serialization error
                print(error)
            }
        }
        task.resume()
    }
}
