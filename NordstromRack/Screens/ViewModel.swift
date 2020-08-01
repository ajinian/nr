//
//  ViewModel.swift
//  NordstromRack
//
//  Created by Arthur Jinian on 8/1/20.
//  Copyright © 2020 AJ. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol DisposeBagProvider {
    var disposeBag: DisposeBag { get }
}

protocol ErrorObservableProvider {
    var error: PublishRelay<Error> { get }
}

class ViewModel: DisposeBagProvider, ErrorObservableProvider {
    let disposeBag = DisposeBag()
    let error = PublishRelay<Error>()
}
