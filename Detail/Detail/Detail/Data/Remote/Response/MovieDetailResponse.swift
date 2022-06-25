//
//  MovieDetailResponse.swift
//  Detail
//
//  Created by candra on 25/06/22.
//

import Foundation

// MARK: - MovieDetailResponse
public struct MovieDetailResponse: Codable {
    public var adult: Bool?
    public var backdropPath: String?
    public var movieID: Int?
    public var originalTitle: String?
    public var overview: String?
    public var popularity: Double?
    public var posterPath: String?
    public var releaseDate: String?
    public var title: String?
    public var video: Bool?
    public var voteAverage: Double?
    public var voteCount: Int?
    public var runtime: Int?
    public var genres: [MovieGenre]?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case movieID = "id"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case runtime, genres
    }
}

public struct MovieGenre: Codable {
    public var id: Int?
    public var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
