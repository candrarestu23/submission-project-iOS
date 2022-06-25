//
//  Array+Ext.swift
//  submissionProject
//
//  Created by candra restu on 18/05/22.
//

import Foundation

extension Array {
    func hasIndex(_ index: Int) -> Bool {
        return indices.contains(index)
    }

    func at(index: Int) -> Element? {
        return hasIndex(index) ? self[index] : nil
    }
}
