//
//  DetailRepository.swift
//  Core
//
//  Created by candra on 25/06/22.
//

import Foundation
import RxSwift

public protocol DetailRepository {
    associatedtype Response
    associatedtype ReviewResponse
    associatedtype CastResponse
    associatedtype Request
    
    func execute(_ urlRequest: URLRequest) -> Observable<Response>
    func getDetailMovie(_ id: Int,_ urlRequest: URLRequest) -> Observable<Response>
    func getMovieReview(_ urlRequest: URLRequest) -> Observable<ReviewResponse>
    func getCast(_ urlRequest: URLRequest) -> Observable<CastResponse>
}
