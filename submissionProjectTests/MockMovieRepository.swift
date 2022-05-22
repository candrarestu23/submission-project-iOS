//
//  MockMovieRepository.swift
//  submissionProjectTests
//
//  Created by candra restu on 22/05/22.
//

import Foundation
import RxSwift
@testable import submissionProject

final class MockMovieRepository: NSObject {
    
    typealias MovieInstance = (MockLocalDataSource, MockMovieDataSource) -> MockMovieRepository
    
    fileprivate let remote: MockMovieDataSource
    fileprivate let locale: MockLocalDataSource
    
    init(locale: MockLocalDataSource, remote: MockMovieDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: MovieInstance = { localeRepo, remoteRepo in
        return MockMovieRepository(locale: localeRepo, remote: remoteRepo)
    }
    
}

extension MockMovieRepository: MovieRepositoryDelegate {

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
        return self.remote.getMovieList()
            .map {
                return MovieMapper.mapMovieToDomain(input: $0)
            }
    }
    
    func getDetailMovie(id: Int) -> Observable<MovieDetailModel> {
        return self.remote.getMovieDetail()
            .map {
                return MovieMapper.mapMovieDetailToDomain(input: $0)
            }
    }
    
    func getMovieReview(id: Int) -> Observable<MovieReviewModel> {
        return self.remote.getReviews()
            .map {
                return MovieMapper.mapMovieReviewToDomain(input: $0)
            }
    }
    
    
}
