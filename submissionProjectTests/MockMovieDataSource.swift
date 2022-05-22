//
//  MockGameDataSource.swift
//  submissionProjectTests
//
//  Created by candra restu on 22/05/22.
//

import Foundation
import RxSwift
import RxCocoa
@testable import submissionProject

final class MockMovieDataSource {
    
    public typealias Request = URLRequest
    public typealias Response = MovieListResponse
    public init() {}
    
    public func getMovieList() -> Observable<MovieListResponse> {
        return Observable<MovieListResponse>.create { observer in
            let decoder = JSONDecoder()
            
            guard let pathString = Bundle(for: type(of: self)).path(forResource: "MockMovieList", ofType: "json") else {
                return observer.onError(fatalError()) as! Disposable
            }
            
            guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
                return observer.onError(fatalError()) as! Disposable
            }
            
            let data = jsonString.data(using: .utf8)!
            
            do {
                let test = try decoder.decode(MovieListResponse.self, from: data)
                observer.onNext(test)
            } catch let error {
                observer.onError(error)
            }
            
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    public func getMovieDetail() -> Observable<MovieDetailResponse> {
        return Observable<MovieDetailResponse>.create { observer in
            let decoder = JSONDecoder()
            
            guard let pathString = Bundle(for: type(of: self)).path(forResource: "MockMovieDetail", ofType: "json") else {
                return observer.onError(fatalError()) as! Disposable
            }
            
            guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
                return observer.onError(fatalError()) as! Disposable
            }
            
            let data = jsonString.data(using: .utf8)!
            
            do {
                let test = try decoder.decode(MovieDetailResponse.self, from: data)
                observer.onNext(test)
            } catch let error {
                observer.onError(error)
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    public func getReviews() -> Observable<MovieReviewResponse> {
        return Observable<MovieReviewResponse>.create { observer in
            let decoder = JSONDecoder()
            
            guard let pathString = Bundle(for: type(of: self)).path(forResource: "MockMovieReviews", ofType: "json") else {
                return observer.onError(fatalError()) as! Disposable
            }
            
            guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
                return observer.onError(fatalError()) as! Disposable
            }
            
            let data = jsonString.data(using: .utf8)!
            
            do {
                let test = try decoder.decode(MovieReviewResponse.self, from: data)
                observer.onNext(test)
            } catch let error {
                observer.onError(error)
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
