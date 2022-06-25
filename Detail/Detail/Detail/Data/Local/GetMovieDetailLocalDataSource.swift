//
//  GetMovieDetailLocalDataSource.swift
//  Detail
//
//  Created by candra on 25/06/22.
//

import Foundation
import RxSwift
import Core
import RealmSwift

public struct GetMovieDetailLocaldataSource: LocaleDataSource {
    
    public typealias Response = MovieEntity
    public typealias Request = MovieEntity
    private let _realm: Realm?
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func getMovieList() -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create { observer in
            if let realm = _realm {
                let categories: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(categories.toArray(ofType: MovieEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(APIError.localDatabaseError)
            }
            return Disposables.create()
        }
    }
    
    public func addMovies(from movies: [MovieEntity]) -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create { observer in
            if let realm = _realm {
                do {
                    try realm.write {
                        for category in movies {
                            realm.add(category, update: .all)
                        }
                        observer.onNext(movies)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(APIError.localDatabaseError)
                }
            } else {
                observer.onError(APIError.localDatabaseError)
            }
            return Disposables.create()
        }
    }
    
    public func addMovie(from movie: MovieEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = _realm {
                do {
                    try realm.write {
                        realm.add(movie, update: .all)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(APIError.localDatabaseError)
                }
            } else {
                observer.onError(APIError.localDatabaseError)
            }
            return Disposables.create()
        }
    }
    
    public func getMovieDetail(id: Int) -> Observable<MovieEntity> {
        return Observable<MovieEntity>.create { observer in
            if let realm = _realm {
                let movie = realm.object(ofType: MovieEntity.self, forPrimaryKey: id)

                guard let movie = movie else {
                    return Disposables.create()
                }
                
                observer.onNext(movie)
                observer.onCompleted()
            } else {
                observer.onError(APIError.localDatabaseError)
            }
            return Disposables.create()
        }
    }
    
    public func removeMovie(from id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = _realm {
                do {
                    try realm.write {
                        let object = realm.object(ofType: MovieEntity.self, forPrimaryKey: id)
                        if let object = object {
                            realm.delete(object)
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(APIError.localDatabaseError)
                }
            } else {
                observer.onError(APIError.localDatabaseError)
            }
            return Disposables.create()
        }
    }
    
    public func removeAllMovies() -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = _realm {
                do {
                    try realm.write {
                        realm.deleteAll()
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(APIError.localDatabaseError)
                }
            } else {
                observer.onError(APIError.localDatabaseError)
            }
            return Disposables.create()
        }
    }
}
