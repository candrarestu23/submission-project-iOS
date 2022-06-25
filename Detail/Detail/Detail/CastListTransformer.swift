//
//  CastListTransformer.swift
//  Detail
//
//  Created by candra on 25/06/22.
//

import Foundation
import Core
import RealmSwift

public struct CastListTransformer : MovieReviewMapper {

    public typealias Response = CastListResponse
    public typealias Domain = CastListModel

    public init() { }
    
    public func transformResponseToDomain(response: CastListResponse) -> CastListModel {
        var tempCast: [CastModel] = []
        var tempCrew: [CastModel] = []
        for item in response.cast ?? [] {
            let data = CastModel(adult: item.adult ?? false,
                                 gender: item.gender ?? 0,
                                 id: item.id ?? 0,
                                 knownForDepartment: item.knownForDepartment ?? "",
                                 name: item.name ?? "",
                                 originalName: item.originalName ?? "",
                                 popularity: item.popularity ?? 0,
                                 profilePath: item.profilePath ?? "",
                                 castID: item.castID ?? 0,
                                 character: item.character ?? "",
                                 creditID: item.creditID ?? "",
                                 order: item.order ?? 0,
                                 department: item.department ?? "",
                                 job: item.job ?? "")
            tempCast.append(data)
        }
        
        for item in response.crew ?? [] {
            let data = CastModel(adult: item.adult ?? false,
                                 gender: item.gender ?? 0,
                                 id: item.id ?? 0,
                                 knownForDepartment: item.knownForDepartment ?? "",
                                 name: item.name ?? "",
                                 originalName: item.originalName ?? "",
                                 popularity: item.popularity ?? 0,
                                 profilePath: item.profilePath ?? "",
                                 castID: item.castID ?? 0,
                                 character: item.character ?? "",
                                 creditID: item.creditID ?? "",
                                 order: item.order ?? 0,
                                 department: item.department ?? "",
                                 job: item.job ?? "")
            tempCrew.append(data)
        }
        return CastListModel(id: response.id ?? 0,
                             cast: tempCast,
                             crew: tempCrew)
    }
}
