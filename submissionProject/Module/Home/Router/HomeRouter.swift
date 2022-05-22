//
//  HomeRouter.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import Foundation
import UIKit

protocol HomeRoutingDelegate : AnyObject {
    func routeToDetailPage(_ id: Int)
    func routeToBottomSheet(delegate: BottomSheetDelegate)
    func routeToFavorite()
}

class HomeRouter {

    var view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension HomeRouter: HomeRoutingDelegate {
    func routeToDetailPage(_ id: Int) {
        let detailController = DetailPageBuilder
            .build(movieID: id,
                   isFavorite: false,
                   movieDetail: nil,
                   container: SceneDelegate.container)
        self.view.navigationController?
            .pushViewController(detailController, animated: true)
    }
    
    func routeToBottomSheet(delegate: BottomSheetDelegate) {
        let bottomSheet = HomeBuilder.build(
            container: SceneDelegate.container,
            delegate: delegate
        )
        self.view.present(bottomSheet, animated: true, completion: nil)
    }
    
    func routeToFavorite() {
        let favoriteController = FavoriteBuilder
            .build(container: SceneDelegate.container)
        self.view.navigationController?
            .pushViewController(favoriteController, animated: true)
    }
}
