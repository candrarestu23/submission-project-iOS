//
//  HomeUsecase.swift
//  Core
//
//  Created by candra on 25/06/22.
//

import RxSwift

public protocol HomeUseCase {
    associatedtype Response
    associatedtype Request
    
    func getMovies(urlRequest: URLRequest) -> Observable<Response>
    func getSearchMovies(urlRequest: URLRequest) -> Observable<Response>
    func removeAllCahce() -> Observable<Bool>
}
