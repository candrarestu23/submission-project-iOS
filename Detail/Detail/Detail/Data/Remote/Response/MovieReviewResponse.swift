//
//  MovieReviewModel.swift
//  Detail
//
//  Created by candra on 25/06/22.
//

// MARK: - MovieReviewResponse
public struct MovieReviewResponse: Codable {
    public var id, page: Int?
    public var results: [MovieReviewResult]?
    public var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct MovieReviewResult: Codable {
    public var author: String?
    public var authorDetails: AuthorDetails?
    public var content, createdAt, id, updatedAt: String?
    public var url: String?

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

public struct AuthorDetails: Codable {
    public var name, username, avatarPath: String?
    public var rating: Int?

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}
