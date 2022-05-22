//
//  DetailViewModel.swift
//  submissionProject
//
//  Created by candra restu on 20/05/22.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel: ObservableObject {
    
    private let disposeBag = DisposeBag()
    private var detailUseCase: DetailUseCase?
//    let data = BehaviorRelay<MovieDetailModel>(value: MovieDetailModel())
    let data = ObservableData<MovieDetailModel>()
    let reviewData = BehaviorRelay<[MovieReviewResultModel]>(value: [MovieReviewResultModel]())
    let isLoading = ObservableData<Bool>()
    let isEmpty = ObservableData<Bool>()
    let errorMessage = ObservableData<String>()
    let page = ObservableData<Int>()
    let type = ObservableData<String>()
    let isSuccessSave = ObservableData<Bool>()
    let isSuccessDelete = ObservableData<Bool>()
    var dataList: [MovieModel] = []
    var isFavorite = false
    var movieID: Int?
    var localData: MovieDetailModel?
    
    init(detailUseCase: DetailUseCase, movieID: Int, isFavorite: Bool, movieData: MovieDetailModel?) {
        self.detailUseCase = detailUseCase
        self.movieID = movieID
        self.isFavorite = isFavorite
        if let movieData = movieData {
            self.localData = movieData
        }
        self.isEmpty.value = true
    }
    
    func getMovieDetail() {
        isLoading.value = true
        detailUseCase?.getDetailMovie(self.movieID ?? 0)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                self?.data.value = result

            } onError: { [weak self] error in
                self?.errorMessage.value = error.localizedDescription
            } onCompleted: {
                self.isLoading.value = false
            }.disposed(by: disposeBag)
    }

    func getMovieReview() {
        detailUseCase?.getMovieReview(self.movieID ?? 0)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                guard let data = result.results else { return }
                self?.reviewData.accept(data)
                self?.isEmpty.value = data.isEmpty
            } onError: { [weak self] error in
                self?.isEmpty.value = true
                self?.errorMessage.value = error.localizedDescription
            } onCompleted: {
                self.isLoading.value = false
            }.disposed(by: disposeBag)
    }
    
    func saveMovie() {
        guard let movieData = data.value else { return }
        detailUseCase?.saveToFavorite(movieData)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                self?.isSuccessSave.value = result
                self?.isFavorite = true
            } onError: { [weak self] error in
                self?.errorMessage.value = error.localizedDescription
            } onCompleted: {
                self.isLoading.value = false
            }.disposed(by: disposeBag)
    }
    
    func deleteMovies() {
        detailUseCase?.removeFromFavorite(self.movieID ?? 0)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                self?.isSuccessDelete.value = result
                self?.isFavorite = false
            } onError: { [weak self] error in
                self?.errorMessage.value = error.localizedDescription
            } onCompleted: {
                self.isLoading.value = false
            }.disposed(by: disposeBag)
    }
    
    func showErrorAlert(errorMessage: String) -> UIAlertController {
        let refreshAlert = UIAlertController(
            title: "Network Error",
            message: "Something work with the netwok, try again later!",
            preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(
            UIAlertAction(title: "Ok",
                          style: .default,
                          handler: { ( _ : UIAlertAction!) in

        }))

        return refreshAlert
    }
    
    func showSaveAlert(message: String) -> UIAlertController {
        let refreshAlert = UIAlertController(
            title: "Success!",
            message: message,
            preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(
            UIAlertAction(title: "Ok",
                          style: .default,
                          handler: { ( _ : UIAlertAction!) in

        }))

        return refreshAlert
    }
}
