//
//  HomeInteractor.swift
//  Core
//
//  Created by candra on 25/06/22.
//

import Foundation
import RxSwift

public struct HomeInteractor<Response, Request, R: Repository>: HomeUseCase
where
R.Response == Response,
R.Request == Request {
    public typealias Response = Response
    public typealias Request = Request
    
    private let _repository: R
    
    public init(repository: R) {
        _repository = repository
    }
    
    public func getMovies(urlRequest: URLRequest) -> Observable<Response> {
        _repository.getMovies(request: urlRequest as? Request)
    }
    
    public func getSearchMovies(urlRequest: URLRequest) -> Observable<Response> {
        _repository.getSearchMovies(request: urlRequest as? Request)
    }
    
    public func removeAllCahce() -> Observable<Bool> {
        _repository.removeAll()
    }
}
