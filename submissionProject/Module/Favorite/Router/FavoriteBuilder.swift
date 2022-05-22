//
//  FavoriteBuilder.swift
//  submissionProject
//
//  Created by candra restu on 21/05/22.
//

import Foundation
import UIKit
import Swinject
import SwinjectStoryboard

class FavoriteBuilder {
    static func build(
        container: Container
    ) -> UIViewController {
        Injection.init().provideFavoriteViewModel(container: container)
        return container.resolve(FavoriteViewController.self) ?? UIViewController()
    }
}
