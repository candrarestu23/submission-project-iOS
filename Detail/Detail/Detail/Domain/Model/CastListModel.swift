//
//  CastListModel.swift
//  Detail
//
//  Created by candra on 25/06/22.
//

import Foundation
public struct CastListModel {
    public var id: Int?
    public var cast, crew: [CastModel]?
    
    public init(
        id: Int,
        cast: [CastModel],
        crew: [CastModel]
    ) {
        self.id = id
        self.cast = cast
        self.crew = crew
    }
}

public struct CastModel {
    public var adult: Bool?
    public var gender, id: Int?
    public var knownForDepartment: String?
    public var name, originalName: String?
    public var popularity: Double?
    public var profilePath: String?
    public var castID: Int?
    public var character, creditID: String?
    public var order: Int?
    public var department: String?
    public var job: String?
    
    public init (
        adult: Bool,
        gender: Int,
        id: Int,
        knownForDepartment: String,
        name: String,
        originalName: String,
        popularity: Double,
        profilePath: String,
        castID: Int,
        character: String,
        creditID: String,
        order: Int,
        department: String,
        job: String
    ) {
        self.adult = adult
        self.gender = gender
        self.id = id
        self.knownForDepartment = knownForDepartment
        self.name = name
        self.originalName = originalName
        self.popularity = popularity
        self.profilePath = profilePath
        self.castID = castID
        self.character = character
        self.order = order
        self.department = department
        self.job = job
    }
}
