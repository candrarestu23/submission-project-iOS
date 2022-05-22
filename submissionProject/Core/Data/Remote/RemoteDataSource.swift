//
//  RemoteDataSource.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol: AnyObject {
    
    func getMovies(from endpoint: MoviesAPI) -> Observable<MovieListResponse>
    func getDetail(from endpoint: MoviesAPI) -> Observable<MovieDetailResponse>
    func getMovieReview(from endpoint: MoviesAPI) -> Observable<MovieReviewResponse>

}

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getDetail(from endpoint: MoviesAPI) -> Observable<MovieDetailResponse> {
        return Observable<MovieDetailResponse>.create { observer in
            AF.request(endpoint.urlRequest)
                .validate()
                .responseDecodable(of: MovieDetailResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    func getMovies(from endpoint: MoviesAPI) -> Observable<MovieListResponse> {
        return Observable<MovieListResponse>.create { observer in
            AF.request(endpoint.urlRequest)
                .validate()
                .responseDecodable(of: MovieListResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    func getMovieReview(from endpoint: MoviesAPI) -> Observable<MovieReviewResponse> {
        return Observable<MovieReviewResponse>.create { observer in
            AF.request(endpoint.urlRequest)
                .validate()
                .responseDecodable(of: MovieReviewResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
}
