//
//  MovieReviewTransformer.swift
//  Detail
//
//  Created by candra on 25/06/22.
//

import Foundation
import Core
import RealmSwift

public struct MovieReviewTransformer : MovieReviewMapper {

    public typealias Response = MovieReviewResponse
    public typealias Domain = MovieReviewModel

    public init() { }
    
    public func transformResponseToDomain(response: MovieReviewResponse) -> MovieReviewModel {
        var tempResultList: [MovieReviewResultModel] = []
        response.results?.forEach { result in
            let author = AuthorDetailsModel(
                name: result.authorDetails?.name ?? "",
                username: result.authorDetails?.username ?? "",
                avatarPath: result.authorDetails?.avatarPath ?? "",
                rating: result.authorDetails?.rating ?? 0)
            
            let data = MovieReviewResultModel(
                author: result.author ?? "",
                authorDetails: author,
                content: result.content ?? "",
                createdAt: result.createdAt ?? "",
                id: result.id ?? "",
                updatedAt: result.updatedAt,
                url: result.url ?? "")
            tempResultList.append(data)
        }
        let result = MovieReviewModel(
            id: response.id ?? 0,
            page: response.page ?? 0,
            results: tempResultList,
            totalPages: response.totalPages ?? 0,
            totalResults: response.totalResults ?? 0)
        
        return result
    }
    
}
