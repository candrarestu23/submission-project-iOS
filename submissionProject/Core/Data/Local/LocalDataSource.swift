//
//  LocalDataSource.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocaleDataSourceProtocol: AnyObject {
    
    func getMovieList() -> Observable<[MovieEntity]>
    func addMovies(from movies: [MovieEntity]) -> Observable<Bool>
    func addMovie(from movie: MovieEntity) -> Observable<Bool>
    func getMovieDetail() -> Observable<MovieEntity>
    func removeMovie(from id: Int) -> Observable<Bool>
    func removeAllMovies() -> Observable<Bool>
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
        
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
    
}

extension LocaleDataSource: LocaleDataSourceProtocol {

    func getMovieDetail() -> Observable<MovieEntity> {
        return Observable<MovieEntity>.create { observer in
            if let realm = self.realm {
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
            if let realm = self.realm {
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
            if let realm = self.realm {
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
            if let realm = self.realm {
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
            if let realm = self.realm {
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
            if let realm = self.realm {
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

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
