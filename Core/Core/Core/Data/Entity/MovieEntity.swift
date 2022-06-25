//
//  MovieEntity.swift
//  Core
//
//  Created by candra on 26/06/22.
//

import Foundation
import RealmSwift

public class MovieEntity: Object {
    
    @objc public dynamic var id: Int = 0
    @objc public dynamic var image: String = ""
    @objc public dynamic var title: String = ""
    @objc public dynamic var overview: String = ""
    @objc public dynamic var releaseDate: String = ""
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
