//
//  DetailUseCase.swift
//  Core
//
//  Created by candra on 25/06/22.
//

import Foundation
import RxSwift

public protocol DetailUseCase {
    associatedtype Request
    associatedtype Response
    associatedtype ReviewResponse
    associatedtype CastResponse
    
    func getDetailMovie(_ id: Int,_ request: URLRequest) -> Observable<Response>
    func getReview(_ request: URLRequest) -> Observable<ReviewResponse>
    func getCast(_ request: URLRequest) -> Observable<CastResponse>

}
