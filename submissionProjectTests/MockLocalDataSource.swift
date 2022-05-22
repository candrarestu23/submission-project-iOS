//
//  MockLocalDataSource.swift
//  submissionProjectTests
//
//  Created by candra restu on 22/05/22.
//

import Foundation
import Foundation
import RxSwift
import RealmSwift
@testable import submissionProject

final class MockLocalDataSource {
    
    public typealias Response = MovieEntity
    public typealias Request = MovieEntity
    private let _realm: Realm?
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    func getMovieDetail() -> Observable<MovieEntity> {
        return Observable<MovieEntity>.create { observer in
            if let realm = self._realm {
                guard let movie = realm.objects(MovieEntity.self).first else { return Disposables.create() }
                observer.onNext(movie)
                observer.onCompleted()
            } else {
                observer.onError(APIError.localDatabaseError)
            }
            return Disposables.create()
        }
    }
    
    func getMovieList() -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create { observer in
            if let realm = self._realm {
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
    
    func addMovies(from movies: [MovieEntity]) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self._realm {
                do {
                    try realm.write {
                        for category in movies {
                            realm.add(category, update: .all)
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
    
    func addMovie(from movie: MovieEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self._realm {
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
    
    func removeMovie(from id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self._realm {
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
    
    func removeAllMovies() -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self._realm {
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
