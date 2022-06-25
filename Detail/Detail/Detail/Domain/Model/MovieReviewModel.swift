//
//  MovieReviewModel.swift
//  Detail
//
//  Created by candra on 25/06/22.
//

import Foundation
public struct MovieReviewModel {
    public var id, page: Int?
    public var results: [MovieReviewResultModel]?
    public var totalPages, totalResults: Int?
    
    public init(
        id: Int?,
        page: Int?,
        results: [MovieReviewResultModel]?,
        totalPages: Int?,
        totalResults: Int?
    ) {
        self.id = id
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
    
    public init() {}
}

public struct MovieReviewResultModel {
    public var author: String?
    public var authorDetails: AuthorDetailsModel?
    public var content, createdAt, id, updatedAt: String?
    public var url: String?
    
    public init(
        author: String?,
        authorDetails: AuthorDetailsModel?,
        content: String?,
        createdAt: String?,
        id: String?,
        updatedAt: String?,
        url: String?
    ) {
        self.author = author
        self.authorDetails = authorDetails
        self.content = content
        self.createdAt = createdAt
        self.id = id
        self.updatedAt = updatedAt
        self.url = url
    }
    
    public init () {}
}

public struct AuthorDetailsModel {
    public var name, username, avatarPath: String?
    public var rating: Int?
    
    init(
        name: String?,
        username: String?,
        avatarPath: String?,
        rating: Int?
    ) {
        self.name = name
        self.username = username
        self.avatarPath = avatarPath
        self.rating = rating
    }
}
