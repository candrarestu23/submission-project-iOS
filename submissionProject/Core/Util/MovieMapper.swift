//
//  MovieMapper.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import Foundation

final class MovieMapper {
    static func mapMovieToDomain(
        input movieList: MovieListResponse
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
    
    static func mapMovieDetailToDomain(
        input movieDetail: MovieDetailResponse
    ) -> MovieDetailModel {
        let data = MovieDetailModel(
            adult: movieDetail.adult ?? false,
            backDropPath: movieDetail.backdropPath ?? "",
            movieID: movieDetail.movieID ?? 0,
            originalTitle: movieDetail.originalTitle ?? "",
            overview: movieDetail.overview ?? "",
            popularity: movieDetail.popularity ?? 0,
            posterPath: movieDetail.posterPath ?? "",
            releaseDate: movieDetail.releaseDate ?? "",
            title: movieDetail.title ?? "",
            video: movieDetail.video ?? false,
            voteAverage: movieDetail.voteAverage ?? 0,
            voteCount: movieDetail.voteCount ?? 0)
        return data
    }
    
    static func mapMovieReviewToDomain(
        input movieReview: MovieReviewResponse
    ) -> MovieReviewModel {
        var tempResultList: [MovieReviewResultModel] = []
        movieReview.results?.forEach { result in
            let author = AuthorDetailsModel(
                name: result.authorDetails?.name ?? "",
                username: result.authorDetails?.username ?? "",
                avatarPath: result.authorDetails?.avatarPath ?? "",
                rating: result.authorDetails?.rating ?? 0)
            
            let data = MovieReviewResultModel(
                author: result.author ?? "",
                authorDetails: author,
                content: result.content ?? "",
                createdAt: result.createdAt ?? "",
                id: result.id ?? "",
                updatedAt: result.updatedAt,
                url: result.url ?? "")
            tempResultList.append(data)
        }
        let result = MovieReviewModel(
            id: movieReview.id ?? 0,
            page: movieReview.page ?? 0,
            results: tempResultList,
            totalPages: movieReview.totalPages ?? 0,
            totalResults: movieReview.totalResults ?? 0)
        
        return result
    }
    
    static func mapMovieToEntity(
        input response: MovieDetailModel
    ) -> MovieEntity {
        let newMovie = MovieEntity()
        newMovie.id = response.movieID ?? 0
        newMovie.title = response.title ?? ""
        newMovie.releaseDate = response.releaseDate ?? ""
        newMovie.image = response.posterPath ?? ""
        newMovie.overview = response.overview ?? ""
        return newMovie
    }
    
    static func mapGameListEntityToDomain(input movieEntities: [MovieEntity]) -> [MovieDetailModel] {
        var tempMovieList: [MovieDetailModel] = []
        for entity in movieEntities {
            let data = MovieDetailModel(
                adult: false,
                backDropPath: "",
                movieID: entity.id,
                originalTitle: "",
                overview: entity.overview,
                popularity: 0,
                posterPath: entity.image,
                releaseDate: entity.releaseDate,
                title: entity.title,
                video: false,
                voteAverage: 0,
                voteCount: 0)
            
            tempMovieList.append(data)
        }
        return tempMovieList
    }
}
