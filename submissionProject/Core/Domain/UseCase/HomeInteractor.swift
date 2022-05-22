//
//  HomeInteractor.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func getMovies(_ page: Int, _ type: String) -> Observable<MovieListModel>
}

class HomeInteractor: HomeUseCase {
    
    private let repository: MovieRepositoryDelegate
    
    required init(repository: MovieRepositoryDelegate) {
        self.repository = repository
    }
    
    func getMovies(_ page: Int, _ type: String) -> Observable<MovieListModel> {
        return repository.getMovies(page: page, type: type)
    }
    
}
