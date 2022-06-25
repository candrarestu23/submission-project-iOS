//
//  CastListResponse.swift
//  Detail
//
//  Created by candra on 25/06/22.
//

import Foundation

public struct CastListResponse: Codable {
    public var id: Int?
    public var cast, crew: [CastResponse]?
}

public struct CastResponse: Codable {
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

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}
