//
//  DetailRouter.swift
//  submissionProject
//
//  Created by candra restu on 21/05/22.
//

import Foundation
import UIKit

protocol DetailRoutingDelegate : AnyObject {
    func routeToBottomSheet()
}

class DetailRouter {

    var view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension DetailRouter: DetailRoutingDelegate {
    func routeToBottomSheet() {
        
    }
}
