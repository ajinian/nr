//
//  Request.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation
import RxSwift

class ApiRequestBuilder <Session: SessionProtocol, Api: ApiProtocol, Model: Codable> {
    
    private let session: Session
    private let api: Api
    private let modelType: Model.Type
    
    init(session: Session, api: Api, modelType: Model.Type) {
        self.session = session
        self.api = api
        self.modelType = modelType
    }
    
    func build() -> Single<Model> {
        let request = URLRequest(url: api.resourceUrl)
        return Single<Model>.create { single in
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
