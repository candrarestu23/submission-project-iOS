//
//  Injection.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import Foundation
import RealmSwift
import Swinject
import SwinjectStoryboard
import Home
import Core
import Detail

final class Injection: NSObject {
    
    func provideHomeViewModel(container: Container) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let realm = appDelegate?.realm else { return }
        let homeViewController = HomeViewController(
            nibName: "HomeViewController",
            bundle: nil)
        container.register(HomeRouter.self) { _ -> HomeRouter in
            return HomeRouter(view: homeViewController)
        }
        
        container.register(HomeViewModel<HomeInteractor<MovieListModel, URLRequest, GetMovieListRepository<GetMoviesDataSource, GetMovieListLocaldataSource, MovieListTransformer>>>.self) { resolver -> HomeViewModel in
            let remote = GetMoviesDataSource()
            let local = GetMovieListLocaldataSource(realm: realm)
            let mapper = MovieListTransformer()
            let repository = GetMovieListRepository(remoteDataSource: remote,
                                                    localDataSource: local,
                                                    transformer: mapper)
            let interactor = HomeInteractor(repository: repository)
            return HomeViewModel(homeUseCase: interactor)
        }

        container.register(HomeViewController.self) { resolver -> HomeViewController in
            homeViewController.viewModel = resolver.resolve(HomeViewModel.self)
            homeViewController.router = resolver.resolve(HomeRouter.self)
            return homeViewController
        }
    }
    
    func provideDetailViewModel(container: Container,
                                movieID: Int,
                                isFavorite: Bool,
                                movieDetail: MovieDetailModel) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let realm = appDelegate?.realm else { return }
        
        let viewController = DetailViewController(nibName: "DetailViewController",
                                                      bundle: nil)
        
        container.register(MovieDetailViewModel<DetailInteractor<URLRequest, MovieDetailModel, MovieReviewModel, CastListModel, GetMovieDetailRepository<GetMovieDetailDataSource, GetMovieReviewDataSource, GetMovieCastDataSource, GetMovieDetailLocaldataSource, MovieDetailTransformer, MovieReviewTransformer, CastListTransformer>>>.self) { resolver -> MovieDetailViewModel in
            let remoteDetail = GetMovieDetailDataSource()
            let remoteReview = GetMovieReviewDataSource()
            let remoteCast = GetMovieCastDataSource()
            let local = GetMovieDetailLocaldataSource(realm: realm)
            let detailTransformer = MovieDetailTransformer()
            let reviewTransformer = MovieReviewTransformer()
            let castTransformer = CastListTransformer()

            let repository = GetMovieDetailRepository(remoteDataSource: remoteDetail,
                                                      reviewDataSource: remoteReview,
                                                      castDataSource: remoteCast,
                                                      localDataSource: local,
                                                      detailTransformer: detailTransformer,
                                                      reviewtransformer: reviewTransformer,
                                                      castTransformer: castTransformer)
            let interactor = DetailInteractor(repository: repository)
            return MovieDetailViewModel(detailUseCase: interactor, movieID: movieID, isFavorite: isFavorite, movieData: movieDetail)
        }

        container.register(DetailViewController.self) { resolver -> DetailViewController in
            viewController.viewModel = resolver.resolve(MovieDetailViewModel.self)
            return viewController
        }
    }
}
