//
//  MovieListResponse.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import Foundation
struct MovieListResponse: Codable {
    var results: [MovieResponse]?
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(result: [MovieResponse]) {
        self.results = result
    }
}

struct MovieResponse: Codable {
    var adult: Bool?
    var backDropPath: String?
    var genreIDs: [Int]?
    var movieID: Int?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var voteAvarage: Double?
    var voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backDropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case movieID = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAvarage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(
        adult: Bool,
        backDropPath: String,
        genreIDs: [Int],
        movieID: Int,
        originalLanguage: String,
        overview: String,
        popularity: Double,
        posterPath: String,
        releaseDate: String,
        title: String,
        originalTitle: String?,
        video: Bool,
        voteAvarage: Double,
        voteCount: Int?
    ) {
        self.adult = adult
        self.backDropPath = backDropPath
        self.genreIDs = genreIDs
        self.movieID = movieID
        self.originalLanguage = originalLanguage
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.originalTitle = title
        self.video = video
        self.voteAvarage = voteAvarage
        self.voteCount = voteCount
    }
}
