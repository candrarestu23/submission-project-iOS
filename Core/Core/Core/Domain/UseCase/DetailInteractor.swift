//
//  DetailInteractor.swift
//  Core∫
//
//  Created by candra on 25/06/22.
//

import Foundation
import RxSwift

public struct DetailInteractor<Request, Response, ReviewResponse, CastResponse, R: DetailRepository>: DetailUseCase
where
R.Response == Response,
R.Request == Request,
R.ReviewResponse == ReviewResponse,
R.CastResponse == CastResponse {

    private let _repository: R
    
    public init(repository: R) {
        _repository = repository
    }
    
    public func getDetailMovie(_ id: Int, _ request: URLRequest) -> Observable<Response> {
        _repository.getDetailMovie(id, request)
    }
    
    public func getReview(_ request: URLRequest) -> Observable<ReviewResponse> {
        _repository.getMovieReview(request)
    }
    
    public func getCast(_ request: URLRequest) -> Observable<CastResponse> {
        _repository.getCast(request)
    }
}
