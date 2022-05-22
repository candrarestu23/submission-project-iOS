//
//  MovieEntity.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import Foundation
import RealmSwift

class MovieEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var image: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseDate: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
