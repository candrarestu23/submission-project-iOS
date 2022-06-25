//
//  HomeViewModel.swift
//  Home
//
//  Created by candra on 25/06/22.
//

import Foundation
import RxSwift
import RxCocoa
import Core

public class HomeViewModel<Interactor: HomeUseCase>: ObservableObject {
    
    private let disposeBag = DisposeBag()
    private var homeUseCase: Interactor?
    public let data = BehaviorRelay<[MovieModel]>(value: [])
    public let isLoading = ObservableData<Bool>()
    public let isEmpty = ObservableData<Bool>()
    public let errorMessage = ObservableData<String>()
    public var page: Int?
    public var type: String?
    public var dataList: [MovieModel] = []
    public var searchKeyword = ""
    
    public init(homeUseCase: Interactor?) {
        self.homeUseCase = homeUseCase
        self.page = 1
        self.type = "popular"
    }
    
    public func getMovies(urlRequest: URLRequest) {
        isLoading.value = true
        homeUseCase?.getMovies(urlRequest: urlRequest)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                let responseData = result as? MovieListModel
                guard let listGameData = responseData?.results else { return }
                self?.dataList.append(contentsOf: listGameData)
                if let data = self?.dataList {
                    self?.data.accept(data)
                }
                self?.isEmpty.value = listGameData.isEmpty
            } onError: { [weak self] error in
                self?.errorMessage.value = error.localizedDescription
            } onCompleted: {
                if let page = self.page {
                    self.page = page + 1
                }
                self.isLoading.value = false
            }.disposed(by: disposeBag)
    }
    
    public func getSearchMovies(urlRequest: URLRequest) {
        isLoading.value = true
        homeUseCase?.getSearchMovies(urlRequest: urlRequest)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                let responseData = result as? MovieListModel
                guard let listGameData = responseData?.results else { return }
                self?.dataList.append(contentsOf: listGameData)
                if let data = self?.dataList {
                    self?.data.accept(data)
                }
                self?.isEmpty.value = listGameData.isEmpty
            } onError: { [weak self] error in
                self?.errorMessage.value = error.localizedDescription
            } onCompleted: {
                if let page = self.page {
                    self.page = page + 1
                }
                self.isLoading.value = false
            }.disposed(by: disposeBag)
    }
    
    public func removeAllCache() {
        homeUseCase?.removeAllCahce()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] isSuccess in
                
            } onError: { [weak self] error in
                self?.errorMessage.value = error.localizedDescription
            } onCompleted: {
                if let page = self.page {
                    self.page = page + 1
                }
                self.isLoading.value = false
            }.disposed(by: disposeBag)
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
}
