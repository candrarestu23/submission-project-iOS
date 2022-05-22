//
//  BottomSheetViewModel.swift
//  submissionProject
//
//  Created by candra restu on 21/05/22.
//

import Foundation
import RxSwift
import RxCocoa

class BottomSheetViewModel: ObservableObject {
    private let disposeBag = DisposeBag()
    let data = BehaviorRelay<[String]>(value: [])
    let categoryName = ["popular", "upcoming", "top rated", "now playing"]
    let categoryID = ["popular", "upcoming", "top_rated", "now_playing"]

    func setupData() {
        data.accept(categoryName)
    }
    
    func onItemListSelected() {
        
    }
}
