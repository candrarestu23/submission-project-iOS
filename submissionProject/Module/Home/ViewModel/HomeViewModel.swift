//
//  HomeViewModel.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ObservableObject {
    
    private let disposeBag = DisposeBag()
    private var homeUseCase: HomeUseCase?
    let data = BehaviorRelay<[MovieModel]>(value: [])
    let isLoading = ObservableData<Bool>()
    let isEmpty = ObservableData<Bool>()
    let errorMessage = ObservableData<String>()
    let page = ObservableData<Int>()
    let type = ObservableData<String>()
    var dataList: [MovieModel] = []
    var router: HomeRouter?

    init(homeUseCase: HomeUseCase?, router: HomeRouter?) {
        self.homeUseCase = homeUseCase
        self.router = router
        self.page.value = 1
        self.type.value = "popular"
    }
    
    func getMovies() {
        isLoading.value = true
        homeUseCase?.getMovies(
            self.page.value ?? 1,
            self.type.value ?? "")
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                guard let listGameData = result.results else { return }
                self?.dataList.append(contentsOf: listGameData)
                if let data = self?.dataList {
                    self?.data.accept(data)
                }
                self?.isEmpty.value = listGameData.isEmpty
            } onError: { [weak self] error in
                self?.errorMessage.value = error.localizedDescription
            } onCompleted: {
                if let page = self.page.value {
                    self.page.value = page + 1
                }
                self.isLoading.value = false
            }.disposed(by: disposeBag)
    }
    
    func onItemListSelected(id: Int) {
        self.router?.routeToDetailPage(id)
    }
    
    func onCategorySelecter(delegate: BottomSheetDelegate) {
        self.router?.routeToBottomSheet(delegate: delegate)
    }
    
    func onFavoriteSelected() {
        self.router?.routeToFavorite()
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
}
