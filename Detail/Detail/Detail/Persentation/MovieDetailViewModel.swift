//
//  MovieDetailViewModel.swift
//  Detail
//
//  Created by candra on 25/06/22.
//

import Foundation
import RxSwift
import RxCocoa
import Core

public class MovieDetailViewModel<Interactor: DetailUseCase>: ObservableObject {
    
    private let disposeBag = DisposeBag()
    private var detailUseCase: Interactor?
    public let data = ObservableData<MovieDetailModel>()
    public let reviewData = BehaviorRelay<[MovieReviewResultModel]>(value: [MovieReviewResultModel]())
    public let castListdata = BehaviorRelay<[CastModel]>(value: [CastModel]())
    public let isLoading = ObservableData<Bool>()
    public let isEmpty = ObservableData<Bool>()
    public let errorMessage = ObservableData<String>()
    public let page = ObservableData<Int>()
    public let type = ObservableData<String>()
    public let isSuccessSave = ObservableData<Bool>()
    public let isSuccessDelete = ObservableData<Bool>()
    public var isFavorite = false
    public var movieID: Int?
    public var localData: MovieDetailModel?
    
    public init(detailUseCase: Interactor, movieID: Int, isFavorite: Bool, movieData: MovieDetailModel?) {
        self.detailUseCase = detailUseCase
        self.movieID = movieID
        self.isFavorite = isFavorite
        if let movieData = movieData {
            self.localData = movieData
        }
        self.isEmpty.value = true
    }
    
    public func getMovieDetail(urlRequest: URLRequest) {
        isLoading.value = true
        detailUseCase?.getDetailMovie(self.movieID ?? 0, urlRequest)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                guard let result = result as? MovieDetailModel else { return }
                self?.data.value = result

            } onError: { [weak self] error in
                self?.errorMessage.value = error.localizedDescription
            } onCompleted: {
                self.isLoading.value = false
            }.disposed(by: disposeBag)
    }

    public func getMovieReview(urlRequest: URLRequest) {
        detailUseCase?.getReview(urlRequest)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                let resultData = result as? MovieReviewModel
                guard let data = resultData?.results else { return }
                self?.reviewData.accept(data)
                self?.isEmpty.value = data.isEmpty
            } onError: { [weak self] error in
                self?.isEmpty.value = true
                self?.errorMessage.value = error.localizedDescription
            } onCompleted: {
                self.isLoading.value = false
            }.disposed(by: disposeBag)
    }
    
    public func getCastList(urlRequst: URLRequest) {
        detailUseCase?.getCast(urlRequst)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                let resultData = result as? CastListModel
                guard let castList = resultData?.cast else { return }
                self?.castListdata.accept(castList)
            } onError: { [weak self] error in
                self?.errorMessage.value = error.localizedDescription
            } onCompleted: {
                self.isLoading.value = false
            }.disposed(by: disposeBag)
    }
    
    public func convertRunTime(runtime: Int) -> String {
        Double(runtime * 60).asString(style: .abbreviated)
    }
    
    public func combineGenre(genre: [MovieGenreModel]) -> String {
        var tempGenre = ""
        
        for item in genre {
            tempGenre.append("\(item.name ?? ""), ")
        }
        return tempGenre
    }
    
    public func showErrorAlert(errorMessage: String) -> UIAlertController {
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
    
    public func showSaveAlert(message: String) -> UIAlertController {
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
