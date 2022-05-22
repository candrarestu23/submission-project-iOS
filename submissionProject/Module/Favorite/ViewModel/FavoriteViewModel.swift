//
//  FavoriteViewModel.swift
//  submissionProject
//
//  Created by candra restu on 21/05/22.
//

import Foundation
import RxSwift
import RxCocoa

class FavoriteViewModel: ObservableObject {
    
    private let disposeBag = DisposeBag()
    private var favoriteUseCase: FavoriteUseCase?
    private var router: FavoriteRouter?
    let isLoading = ObservableData<Bool>()
    let isEmpty = ObservableData<Bool>()
    let errorMessage = ObservableData<String>()
    let data = BehaviorRelay<[MovieDetailModel]>(value: [])

    init(favoriteUseCase: FavoriteUseCase?, router: FavoriteRouter?) {
        self.favoriteUseCase = favoriteUseCase
        self.router = router
    }
    
    func getMovies() {
        favoriteUseCase?.getMovies()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                self?.data.accept(result)
                self?.isEmpty.value = result.isEmpty
            } onError: { [weak self] error in
                self?.errorMessage.value = error.localizedDescription
            } onCompleted: {
                self.isLoading.value = false
            }.disposed(by: disposeBag)
    }
    
    func onItemSelected(data: MovieDetailModel) {
        self.router?.routeToDetailPage(movieData: data)
    }
}
