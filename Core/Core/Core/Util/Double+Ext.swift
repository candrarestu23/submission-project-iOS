//
//  Double+Ext.swift
//  Core
//
//  Created by candra on 25/06/22.
//

import Foundation
extension Double {
    public func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.unitsStyle = style
        return formatter.string(from: self) ?? ""
    }
}
