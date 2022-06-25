//
//  Repository.swift
//  Core
//
//  Created by candra on 25/06/22.
//

import RxSwift

public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> Observable<Response>
    func getMovies(request: Request?) -> Observable<Response>
    func getSearchMovies(request: Request?) -> Observable<Response>
    func saveToLocal(movie: Request) -> Observable<Bool>
    func removeAll() -> Observable<Bool>
}
