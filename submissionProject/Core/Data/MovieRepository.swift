//
//  MovieRepository.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import Foundation
import RxSwift

protocol MovieRepositoryDelegate: AnyObject {
    
    func getMovies(page: Int, type: String) -> Observable<MovieListModel>
    func getDetailMovie(id: Int) -> Observable<MovieDetailModel>
    func getMovieReview(id: Int) -> Observable<MovieReviewModel>
    func getFavorite() -> Observable<[MovieDetailModel]>
    func saveToFavorite(movie: MovieDetailModel) -> Observable<Bool>
    func removeFromFavorite(id: Int) -> Observable<Bool>
    func removeAllFavorite() -> Observable<Bool>
}

final class MovieRepository: NSObject {
    
    typealias MovieInstance = (LocaleDataSource, RemoteDataSource) -> MovieRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: MovieInstance = { localeRepo, remoteRepo in
        return MovieRepository(locale: localeRepo, remote: remoteRepo)
    }
    
}

extension MovieRepository: MovieRepositoryDelegate {

    func getFavorite() -> Observable<[MovieDetailModel]> {
        self.locale.getMovieList()
            .map {
                return MovieMapper.mapGameListEntityToDomain(input: $0)
            }
    }
    
    func saveToFavorite(movie: MovieDetailModel) -> Observable<Bool> {
        self.locale.addMovie(from: MovieMapper.mapMovieToEntity(input: movie))
    }
    
    func removeFromFavorite(id: Int) -> Observable<Bool> {
        self.locale.removeMovie(from: id)
    }
    
    func removeAllFavorite() -> Observable<Bool> {
        self.locale.removeAllMovies()
    }
    
    func getMovies(page: Int, type: String) -> Observable<MovieListModel> {
        return self.remote.getMovies(from:
            .getMovies(
                page,
                type
            ))
            .map {
                return MovieMapper.mapMovieToDomain(input: $0)
            }
    }
    
    func getDetailMovie(id: Int) -> Observable<MovieDetailModel> {
        return self.remote.getDetail(from: .getMovieDetail(id))
            .map {
                return MovieMapper.mapMovieDetailToDomain(input: $0)
            }
    }
    
    func getMovieReview(id: Int) -> Observable<MovieReviewModel> {
        return self.remote.getMovieReview(from: .getMovieReview(id))
            .map {
                return MovieMapper.mapMovieReviewToDomain(input: $0)
            }
    }
}
