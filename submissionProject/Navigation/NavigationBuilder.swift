//
//  NavigationBuilder.swift
//  submissionProject
//
//  Created by candra restu on 18/05/22.
//

import Foundation
import UIKit

typealias NavigationFactory = (UIViewController) -> (UINavigationController)

class NavigationBuilder {
    static func build(rootView: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootView)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController.navigationBar.barTintColor = .blue
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        return navigationController
    }
}
