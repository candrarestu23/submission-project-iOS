//
//  MockReviewDataSource.swift
//  submissionProjectTests
//
//  Created by candra on 26/06/22.
//

import Foundation
import RxSwift
import RxCocoa
import Core
import Detail

final class MockReviewDataSource: DataSource {

    public typealias Request = URLRequest
    public typealias Response = MovieReviewResponse
    public init() {}
    
    func execute(request: URLRequest?) -> Observable<Response> {
        return Observable<Response>.create { observer in
            let decoder = JSONDecoder()
            
            guard let pathString = Bundle(for: type(of: self)).path(forResource: "MockMovieReviews", ofType: "json") else {
                return observer.onError(fatalError()) as! Disposable
            }
            
            guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
                return observer.onError(fatalError()) as! Disposable
            }
            
            let data = jsonString.data(using: .utf8)!
            
            do {
                let test = try decoder.decode(Response.self, from: data)
                observer.onNext(test)
            } catch let error {
                observer.onError(error)
            }
            
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
