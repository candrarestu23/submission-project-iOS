//
//  LoadingOverlay.swift
//  submissionProject
//
//  Created by candra restu on 18/05/22.
//

import Foundation
import UIKit

class LoadingOverlay {
    
    private init() {}
    static let shared = LoadingOverlay()
    
    func showLoading() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()

        alert.view.addSubview(loadingIndicator)
        let keyWindow =  UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        keyWindow?
            .rootViewController?
            .present(alert, animated: true, completion: nil)
    }
    
    func dismissLoading() {
        let keyWindow =  UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        keyWindow?
            .rootViewController?
            .dismiss(animated: true, completion: nil)
        
    }
    
}
