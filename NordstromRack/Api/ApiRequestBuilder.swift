//
//  Request.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation
import RxSwift

class ApiRequestBuilder <S: SessionProtocol, A: ApiProtocol, C: Codable> {
    
    private let session: S
    private let api: A
    private let modelType: C.Type
    
    init(session: S, api: A, modelType: C.Type) {
        self.session = session
        self.api = api
        self.modelType = modelType
    }
    
    func build() -> Single<C> {
        let request = URLRequest(url: api.resourceUrl)
        return Single<C>.create { single in
            let task = self.session.apiSession.dataTask(with: request) { (data, response, error) in
                print(request.url?.absoluteString ?? "")
                if let error = error {
                    single(.error(error))
                    return
                }
                let decoder = JSONDecoder()
                guard let data = data, let model = try? decoder.decode(self.modelType, from: data) else { return }
                single(.success(model))
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}
