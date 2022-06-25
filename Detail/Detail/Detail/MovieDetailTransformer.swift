//
//  MovieDetailTransformer.swift
//  Detail
//
//  Created by candra on 25/06/22.
//

import Core
import RealmSwift

public struct MovieDetailTransformer : MovieDetailMapper {


    public typealias Response = MovieDetailResponse
    public typealias Domain = MovieDetailModel
    public typealias Entity = MovieEntity

    public init() { }
    
    public func transformResponseToDomain(response: MovieDetailResponse) -> MovieDetailModel {
        var genres: [MovieGenreModel] = []
        
        for item in response.genres ?? [] {
            let data = MovieGenreModel(id: item.id ?? 0,
                                       name: item.name ?? "")
            genres.append(data)
        }
        
        let data = MovieDetailModel(
            adult: response.adult ?? false,
            backDropPath: response.backdropPath ?? "",
            movieID: response.movieID ?? 0,
            originalTitle: response.originalTitle ?? "",
            overview: response.overview ?? "",
            popularity: response.popularity ?? 0,
            posterPath: response.posterPath ?? "",
            releaseDate: response.releaseDate ?? "",
            title: response.title ?? "",
            video: response.video ?? false,
            voteAverage: response.voteAverage ?? 0,
            voteCount: response.voteCount ?? 0,
            runtime: response.runtime ?? 0,
            genres: genres
        )
        return data
    }
    
    public func transformDomainToEntity(domain: MovieDetailModel) -> MovieEntity {
        let newMovie = MovieEntity()
        newMovie.id = domain.movieID ?? 0
        newMovie.title = domain.title ?? ""
        newMovie.releaseDate = domain.releaseDate ?? ""
        newMovie.image = domain.posterPath ?? ""
        newMovie.overview = domain.overview ?? ""
        return newMovie
    }
    
    public func transformEntityToDomain(domain: MovieEntity) -> MovieDetailModel {
        return MovieDetailModel(adult: false,
                                backDropPath: "",
                                movieID: domain.id,
                                originalTitle: domain.title,
                                overview: domain.overview,
                                popularity: 0,
                                posterPath: domain.image,
                                releaseDate: domain.releaseDate,
                                title: domain.title,
                                video: false,
                                voteAverage: 0,
                                voteCount: 0,
                                runtime: 0,
                                genres: [])
    }
}
