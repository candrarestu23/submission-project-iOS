//
//  FavoriteRouter.swift
//  submissionProject
//
//  Created by candra restu on 22/05/22.
//

import Foundation
import UIKit

protocol FavoriteRoutingDelegate : AnyObject {
    func routeToDetailPage(movieData: MovieDetailModel)
}

class FavoriteRouter {

    var view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension FavoriteRouter: FavoriteRoutingDelegate {
    func routeToDetailPage(movieData: MovieDetailModel) {
        let detailController = DetailPageBuilder
            .build(movieID: movieData.movieID ?? 0,
                   isFavorite: true,
                   movieDetail: movieData,
                   container: SceneDelegate.container)
        self.view.navigationController?
            .pushViewController(detailController, animated: true)
    }
}
