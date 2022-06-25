//
//  MovieListTransformer.swift
//  Home
//
//  Created by candra on 25/06/22.
//

import Core
import RealmSwift

public struct MovieListTransformer : MovieListMapper {

    
    public typealias Response = MovieListResponse
    public typealias Domain = MovieListModel
    public typealias Entity = MovieEntity

    public init() { }
    
    public func transformResponseToDomain(
        response movieList: MovieListResponse
    ) -> MovieListModel {
        var tempMovies: [MovieModel] = []
        if let result = movieList.results {
            for movie in result {
                
                let data = MovieModel(
                    adult: movie.adult ?? false,
                    backDropPath: movie.backDropPath ?? "",
                    genreIDs: movie.genreIDs ?? [],
                    movieID: movie.movieID ?? 0,
                    originalLanguage: movie.originalLanguage ?? "",
                    overview: movie.overview ?? "",
                    popularity: movie.popularity ?? 0,
                    posterPath: movie.posterPath ?? "",
                    releaseDate: movie.releaseDate ?? "",
                    title: movie.title ?? "",
                    originalTitle: movie.originalTitle ?? "",
                    video: movie.video ?? false,
                    voteAvarage: movie.voteAvarage ?? 0,
                    voteCount: movie.voteCount ?? 0)
                tempMovies.append(data)
                
            }
        }
        return MovieListModel(result: tempMovies)
    }
    
    public func transformDomainToEntity(domain: MovieListModel) -> [MovieEntity] {
        var tempMovies: [MovieEntity] = []
        
        for item in domain.results ?? [] {
            let newMovie = MovieEntity()
            newMovie.id = item.movieID ?? 0
            newMovie.title = item.title ?? ""
            newMovie.releaseDate = item.releaseDate ?? ""
            newMovie.image = item.posterPath ?? ""
            newMovie.overview = item.overview ?? ""
            tempMovies.append(newMovie)
        }
        return tempMovies
    }
    
    public func transformEntityToDomain(entity: [MovieEntity]) -> MovieListModel {
        var tempList: [MovieModel] = []
        
        for entity in entity {
            let data = MovieModel(
                adult: false,
                backDropPath: "",
                genreIDs: [0],
                movieID: entity.id,
                originalLanguage: "",
                overview: entity.overview,
                popularity: 0,
                posterPath: entity.image,
                releaseDate: entity.releaseDate,
                title: entity.title,
                originalTitle: entity.title,
                video: false,
                voteAvarage: 0,
                voteCount: 0)
            tempList.append(data)
        }
        return MovieListModel(result: tempList)
    }
}

