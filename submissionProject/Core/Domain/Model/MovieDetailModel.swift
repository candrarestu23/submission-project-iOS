//
//  MovieDetailModel.swift
//  submissionProject
//
//  Created by candra restu on 20/05/22.
//

import Foundation
import UIKit

struct MovieDetailModel {
    var adult: Bool?
    var backdropPath: String?
    var movieID: Int?
    var originalTitle, overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    
    init(
        adult: Bool,
        backDropPath: String,
        movieID: Int,
        originalTitle: String,
        overview: String,
        popularity: Double,
        posterPath: String,
        releaseDate: String,
        title: String,
        video: Bool,
        voteAverage: Double,
        voteCount: Int
    ) {
        self.adult = adult
        self.backdropPath = backDropPath
        self.movieID = movieID
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
    
    init() {}
}
