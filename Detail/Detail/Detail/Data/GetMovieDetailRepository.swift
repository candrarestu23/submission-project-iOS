//
//  GetMovieDetailRepository.swift
//  Detail
//
//  Created by candra on 25/06/22.
//

import Foundation
import Core
import RxSwift

public struct GetMovieDetailRepository<
    RemoteDataSource: DataSource,
    ReviewDataSource: DataSource,
    CastDataSource: DataSource,
    LocalDataSource: LocaleDataSource,
    DetailTransformer: MovieDetailMapper,
    ReviewTransformer: MovieReviewMapper,
    CastTransformer: MovieReviewMapper> : DetailRepository

where
RemoteDataSource.Response == MovieDetailResponse,
RemoteDataSource.Request == URLRequest,
ReviewDataSource.Response == MovieReviewResponse,
ReviewDataSource.Request == URLRequest,
CastDataSource.Response == CastListResponse,
CastDataSource.Request == URLRequest,
LocalDataSource.Response == MovieEntity,
LocalDataSource.Request == MovieEntity,
DetailTransformer.Response == MovieDetailResponse,
DetailTransformer.Domain == MovieDetailModel,
DetailTransformer.Entity == MovieEntity,
ReviewTransformer.Response == MovieReviewResponse,
ReviewTransformer.Domain == MovieReviewModel,
CastTransformer.Response == CastListResponse,
CastTransformer.Domain == CastListModel {

    public typealias Request = URLRequest
    public typealias Response = MovieDetailModel
    public typealias ReviewResponse = MovieReviewModel
    public typealias CastResponse = CastListModel
    
    private let _remoteDataSource: RemoteDataSource
    private let _reviewDataSource: ReviewDataSource
    private let _castDataSource: CastDataSource
    private let _localDataSource: LocalDataSource
    private let _mapper: DetailTransformer
    private let _reviewMapper: ReviewTransformer
    private let _castMapper: CastTransformer
    
    public init(
        remoteDataSource: RemoteDataSource,
        reviewDataSource: ReviewDataSource,
        castDataSource: CastDataSource,
        localDataSource: LocalDataSource,
        detailTransformer: DetailTransformer,
        reviewtransformer: ReviewTransformer,
        castTransformer: CastTransformer
    ) {
        _remoteDataSource = remoteDataSource
        _reviewDataSource = reviewDataSource
        _castDataSource = castDataSource
        _localDataSource = localDataSource
        _mapper = detailTransformer
        _reviewMapper = reviewtransformer
        _castMapper = castTransformer
    }

    public func execute(_ urlRequest: URLRequest) -> Observable<MovieDetailModel> {
        return _remoteDataSource.execute(request: urlRequest)
            .map {
                return _mapper.transformResponseToDomain(response: $0)
            }.catch { _ in
                return _localDataSource.getMovieDetail(id: 1)
                    .map {
                        return _mapper.transformEntityToDomain(domain: $0)
                    }
            }
    }
    
    public func getDetailMovie(_ id: Int, _ urlRequest: URLRequest) -> Observable<MovieDetailModel> {
        return _remoteDataSource.execute(request: urlRequest)
            .map {
                return _mapper.transformResponseToDomain(response: $0)
            }.catch { _ in
                return _localDataSource.getMovieDetail(id: id)
                    .map {
                        return _mapper.transformEntityToDomain(domain: $0)
                    }
            }
    }
    
    
    public func getMovieReview(_ urlRequest: URLRequest) -> Observable<MovieReviewModel> {
        return _reviewDataSource.execute(request: urlRequest)
            .map {
                return _reviewMapper.transformResponseToDomain(response: $0)
            }
    }
    
    public func getCast(_ urlRequest: URLRequest) -> Observable<CastListModel> {
        return _castDataSource.execute(request: urlRequest)
            .map {
                return _castMapper.transformResponseToDomain(response: $0)
            }
    }
    
}
