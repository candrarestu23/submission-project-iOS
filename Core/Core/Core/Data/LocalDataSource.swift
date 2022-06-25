//
//  LocalDataSource.swift
//  Core
//
//  Created by candra on 25/06/22.
//

import Foundation
import RxSwift

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func getMovieList() -> Observable<[Response]>
    func addMovies(from movies: [Request]) -> Observable<[Response]>
    func addMovie(from movie: Request) -> Observable<Bool>
    func getMovieDetail(id: Int) -> Observable<Response>
    func removeMovie(from id: Int) -> Observable<Bool>
    func removeAllMovies() -> Observable<Bool>
}
