//
//  DetailInteractor.swift
//  submissionProject
//
//  Created by candra restu on 20/05/22.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    
    func getDetailMovie(_ id: Int) -> Observable<MovieDetailModel>
    func getMovieReview(_ id: Int) -> Observable<MovieReviewModel>
    func saveToFavorite(_ movie: MovieDetailModel) -> Observable<Bool>
    func removeFromFavorite(_ id: Int) -> Observable<Bool>
}

class DetailInteractor: DetailUseCase {

    private let repository: MovieRepositoryDelegate
    
    required init(repository: MovieRepositoryDelegate) {
        self.repository = repository
    }
    
    func getDetailMovie(_ id: Int) -> Observable<MovieDetailModel> {
        return self.repository.getDetailMovie(id: id)
    }
    
    func getMovieReview(_ id: Int) -> Observable<MovieReviewModel> {
        return self.repository.getMovieReview(id: id)
    }
    
    func saveToFavorite(_ movie: MovieDetailModel) -> Observable<Bool> {
        return self.repository.saveToFavorite(movie: movie)
    }
    
    func removeFromFavorite(_ id: Int) -> Observable<Bool> {
        return self.repository.removeFromFavorite(id: id)
    }
}
