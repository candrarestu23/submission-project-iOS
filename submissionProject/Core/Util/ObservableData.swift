//
//  ObservableData.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import Foundation
import RxSwift

class ObservableData<DATA> {
    var value: DATA? = nil {
        didSet {
            observers.onNext(value)
        }
    }
    
    private let observers = PublishSubject<DATA?>()
    
    init(_ data: DATA? = nil) {
        self.value = data
    }
    
    func observe(_ disposeBag: DisposeBag, observer:  @escaping (DATA?) -> Void) {
        observers
            .subscribe(onNext: observer, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
}
