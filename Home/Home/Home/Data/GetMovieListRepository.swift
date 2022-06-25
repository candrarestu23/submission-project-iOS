//
//  GetMovieListRepository.swift
//  Home
//
//  Created by candra on 25/06/22.
//

import Foundation
import Core
import RxSwift

public struct GetMovieListRepository<
    RemoteDataSource: DataSource,
    LocalDataSource: LocaleDataSource,
    Transformer: MovieListMapper> : Repository
where
RemoteDataSource.Response == MovieListResponse,
RemoteDataSource.Request == URLRequest,
LocalDataSource.Response == MovieEntity,
LocalDataSource.Request == MovieEntity,
Transformer.Response == MovieListResponse,
Transformer.Domain == MovieListModel,
Transformer.Entity == MovieEntity {

    public typealias Request = URLRequest
    public typealias Response = MovieListModel
    
    private let _remoteDataSource: RemoteDataSource
    private let _localDataSource: LocalDataSource
    private let _mapper: Transformer
    
    public init(
        remoteDataSource: RemoteDataSource,
        localDataSource: LocalDataSource,
        transformer: Transformer
    ) {
        _remoteDataSource = remoteDataSource
        _localDataSource = localDataSource
        _mapper = transformer
    }
    
    public func execute(request: URLRequest?) -> Observable<MovieListModel> {
        return _remoteDataSource.execute(request: request)
            .map {
                _mapper.transformResponseToDomain(response: $0)
            }
            .map {
                _mapper.transformDomainToEntity(domain: $0)
            }
            .flatMap {
                _localDataSource.addMovies(from: $0)
            }
            .map {
                return _mapper.transformEntityToDomain(entity: $0)
            }
            .catch { _ in
                return _localDataSource.getMovieList()
                    .map {
                        return _mapper.transformEntityToDomain(entity: $0)
                    }
            }
    }
    
    public func getMovies(request: URLRequest?) -> Observable<MovieListModel> {
        return _remoteDataSource.execute(request: request)
            .map {
                _mapper.transformResponseToDomain(response: $0)
            }
            .map {
                _mapper.transformDomainToEntity(domain: $0)
            }
            .flatMap {
                _localDataSource.addMovies(from: $0)
            }
            .map {
                return _mapper.transformEntityToDomain(entity: $0)
            }
            .catch { _ in
                return _localDataSource.getMovieList()
                    .map {
                        return _mapper.transformEntityToDomain(entity: $0)
                    }
            }
    }
    
    public func getSearchMovies(request: URLRequest?) -> Observable<MovieListModel> {
        return _remoteDataSource.execute(request: request)
            .map {
                _mapper.transformResponseToDomain(response: $0)
            }
            .map {
                _mapper.transformDomainToEntity(domain: $0)
            }
            .flatMap {
                _localDataSource.addMovies(from: $0)
            }
            .map {
                return _mapper.transformEntityToDomain(entity: $0)
            }
            .catch { _ in
                return _localDataSource.getMovieList()
                    .map {
                        return _mapper.transformEntityToDomain(entity: $0)
                    }
            }
    }
    
    public func saveToLocal(movie: URLRequest) -> Observable<Bool> {
        _localDataSource.removeAllMovies()
    }
    
    public func removeAll() -> Observable<Bool> {
        _localDataSource.removeAllMovies()
    }
}
