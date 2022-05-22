//
//  HomeBuilder.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import Foundation
import UIKit
import Swinject
import SwinjectStoryboard

class HomeBuilder {
    static func build(
        usingNavigationFactory factory: NavigationFactory,
        container: Container
    ) -> UIViewController {
        Injection.init().provideHomeViewModel(container: container)
        return factory(container.resolve(HomeViewController.self) ?? UIViewController())
    }
    
    static func build(
        container: Container,
        delegate: BottomSheetDelegate
    ) -> UIViewController {
        Injection.init().provideBottomSheetViewModel(
            container: container,
            delegate: delegate
        )
        return container.resolve(BottomSheetViewController.self) ?? UIViewController()
    }
}
