//
//  UIView+Ext.swift
//  submissionProject
//
//  Created by candra restu on 20/05/22.
//

import Foundation
import UIKit

extension UIView {
    public func dropShadow(
        color: UIColor,
        offSet: CGSize,
        radius: CGFloat = 1,
        opacity: Float = 1,
        shouldUseNaturalScale: Bool = true) {
        clipsToBounds = false
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = shouldUseNaturalScale ? UIScreen.main.scale : 1
    }
    
    public func dropShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
    }
}
