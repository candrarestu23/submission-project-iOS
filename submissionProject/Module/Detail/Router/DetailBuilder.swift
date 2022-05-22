//
//  DetailBuilder.swift
//  submissionProject
//
//  Created by candra restu on 20/05/22.
//

import Foundation
import UIKit
import Swinject
import SwinjectStoryboard

class DetailPageBuilder {
    static func build(movieID id: Int,
                      isFavorite: Bool,
                      movieDetail: MovieDetailModel?,
                      container: Container) -> UIViewController {
        
        Injection.init().provideDetailViewModel(
            container: container,
            movieID: id,
            isFavorite: isFavorite,
            movieDetail: movieDetail ?? MovieDetailModel())
        return container.resolve(DetailViewController.self) ?? UIViewController()
    }
}
