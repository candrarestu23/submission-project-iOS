//
//  MovieListModel.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import Foundation

struct MovieListModel {
    var results: [MovieModel]?
    
    init(result: [MovieModel]) {
        self.results = result
    }
}

struct MovieModel {
    var adult: Bool?
    var backDropPath: String?
    var genreIDs: [Int?]
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
    
    init(adult: Bool,
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
