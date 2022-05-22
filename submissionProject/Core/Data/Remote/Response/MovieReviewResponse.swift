//
//  MovieReviewResponse.swift
//  submissionProject
//
//  Created by candra restu on 20/05/22.
//

import Foundation

// MARK: - MovieReviewResponse
struct MovieReviewResponse: Codable {
    var id, page: Int?
    var results: [MovieReviewResult]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieReviewResult: Codable {
    var author: String?
    var authorDetails: AuthorDetails?
    var content, createdAt, id, updatedAt: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    var name, username, avatarPath: String?
    var rating: Int?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}
