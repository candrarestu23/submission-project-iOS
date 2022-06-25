//
//  MovieListModel.swift
//  Home
//
//  Created by candra on 25/06/22.
//

import Foundation

public struct MovieListModel {
    public var results: [MovieModel]?
    
    public init(result: [MovieModel]) {
        self.results = result
    }
}

public struct MovieModel {
    public var adult: Bool?
    public var backDropPath: String?
    public var genreIDs: [Int?]
    public var movieID: Int?
    public var originalLanguage: String?
    public var originalTitle: String?
    public var overview: String?
    public var popularity: Double?
    public var posterPath: String?
    public var releaseDate: String?
    public var title: String?
    public var video: Bool?
    public var voteAvarage: Double?
    public var voteCount: Int?
    
    public init(adult: Bool,
         backDropPath: String,
         genreIDs: [Int],
         movieID: Int,
         originalLanguage: String,
         overview: String,
         popularity: Double,
         posterPath: String,
         releaseDate: String,
         title: String,
         originalTitle: String,
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
        self.originalTitle = originalTitle
        self.video = video
        self.voteAvarage = voteAvarage
        self.voteCount = voteCount
    }
}
