//
//  HomeRouter.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import Foundation
import UIKit
import Detail

protocol HomeRoutingDelegate : AnyObject {
    func routeToDetailPage(_ id: Int)
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
                   movieDetail: MovieDetailModel(),
                   container: SceneDelegate.container)
        self.view.navigationController?
            .pushViewController(detailController, animated: true)
    }
}
