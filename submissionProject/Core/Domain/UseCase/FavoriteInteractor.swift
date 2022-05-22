//
//  FavoriteInteractor.swift
//  submissionProject
//
//  Created by candra restu on 21/05/22.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    func getMovies() -> Observable<[MovieDetailModel]>
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: MovieRepositoryDelegate
    
    required init(repository: MovieRepositoryDelegate) {
        self.repository = repository
    }
    
    func getMovies() -> Observable<[MovieDetailModel]> {
        return repository.getFavorite()
    }
    
}
