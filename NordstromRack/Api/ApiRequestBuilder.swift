//
//  Request.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation
import RxSwift

class ApiRequestBuilder {
    
    private let session: SessionProtocol
    private let api: ApiProtocol
    private let modelType: Codable.Type
    
    init(session: SessionProtocol, api: ApiProtocol, modelType: Codable.Type) {
        self.session = session
        self.api = api
        self.modelType = modelType
    }
    
    func build<T: Codable>() -> Single<T> {
        let request = URLRequest(url: api.resourceUrl)
        return Single<T>.create { single in
            let task = self.session.apiSession.dataTask(with: request) { (data, response, error) in
                print(request.url?.absoluteString ?? "")
                if let error = error {
                    single(.error(error))
                    return
                }
                let decoder = JSONDecoder()
                guard let data = data, let model = try? decoder.decode(T.self, from: data) else { return }
                single(.success(model))
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}
