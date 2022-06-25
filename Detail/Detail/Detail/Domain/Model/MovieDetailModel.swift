//
//  MovieDetailModel.swift
//  Detail
//
//  Created by candra on 25/06/22.
//

import Foundation
import UIKit

public struct MovieDetailModel {
    public var adult: Bool?
    public var backdropPath: String?
    public var movieID: Int?
    public var originalTitle, overview: String?
    public var popularity: Double?
    public var posterPath: String?
    public var releaseDate: String?
    public var title: String?
    public var video: Bool?
    public var voteAverage: Double?
    public var voteCount: Int?
    public var runtime: Int?
    public var genres: [MovieGenreModel]?
    
    public init(
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
        voteCount: Int,
        runtime: Int,
        genres: [MovieGenreModel]?
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
        self.runtime = runtime
        self.genres = genres
    }
    
    public init() {}
}

public struct MovieGenreModel {
    public var id: Int?
    public var name: String?
    
    public init(
        id: Int,
        name: String
    ) {
        self.id = id
        self.name = name
    }
    
    public init() {}
}
