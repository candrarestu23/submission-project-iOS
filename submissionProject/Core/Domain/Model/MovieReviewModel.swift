//
//  MovieReviewModel.swift
//  submissionProject
//
//  Created by candra restu on 20/05/22.
//

import Foundation
struct MovieReviewModel {
    var id, page: Int?
    var results: [MovieReviewResultModel]?
    var totalPages, totalResults: Int?
    
    init(
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
    
    init() {}
}

struct MovieReviewResultModel {
    var author: String?
    var authorDetails: AuthorDetailsModel?
    var content, createdAt, id, updatedAt: String?
    var url: String?
    
    init(
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
    
    init () {}
}

struct AuthorDetailsModel {
    var name, username, avatarPath: String?
    var rating: Int?
    
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
