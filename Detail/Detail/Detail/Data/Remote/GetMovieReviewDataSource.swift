//
//  GetMovieReviewDataSource.swift
//  Detail
//
//  Created by candra on 25/06/22.
//

import Foundation
import RxSwift
import Core
import Alamofire

public struct GetMovieReviewDataSource: DataSource {

    public typealias Request = URLRequest
    public typealias Response = MovieReviewResponse
    public init() {}
    
    public func execute(request: URLRequest?) -> Observable<Response> {
        return Observable<Response>.create { observer in
            AF.request(request!)
                .validate()
                .responseDecodable(of: Response.self) { response in
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
