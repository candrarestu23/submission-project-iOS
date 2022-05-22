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

final class Injection: NSObject {
    
    private func provideRepository() -> MovieRepositoryDelegate {
        let realm = try? Realm()
        
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return MovieRepository.sharedInstance(locale, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
    
    func provideDetail() -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository)
    }
    
    func provideHomeViewModel(container: Container) {
        let homeViewController = HomeViewController(
            nibName: "HomeViewController",
            bundle: nil)
        container.register(HomeRouter.self) { _ -> HomeRouter in
            return HomeRouter(view: homeViewController)
        }
        
        container.register(HomeViewModel.self) { resolver -> HomeViewModel in
            return HomeViewModel(homeUseCase: self.provideHome(),
                                 router: resolver.resolve(HomeRouter.self)!)
        }
        
        container.register(HomeViewController.self) { resolver -> HomeViewController in
            homeViewController.viewModel = resolver.resolve(HomeViewModel.self)
            return homeViewController
        }
    }
    
    func provideDetailViewModel(container: Container,
                                movieID: Int,
                                isFavorite: Bool,
                                movieDetail: MovieDetailModel) {
        let viewController = DetailViewController(nibName: "DetailViewController",
                                                      bundle: nil)
        
        container.register(DetailViewModel.self) { _ -> DetailViewModel in
            return DetailViewModel(
                detailUseCase: self.provideDetail(),
                movieID: movieID,
                isFavorite: isFavorite,
                movieData: movieDetail)
        }
        
        container.register(DetailViewController.self) { resolver -> DetailViewController in
            viewController.viewModel = resolver.resolve(DetailViewModel.self)
            return viewController
        }
    }
    
    func provideBottomSheetViewModel(container: Container, delegate: BottomSheetDelegate) {
        let viewController = BottomSheetViewController(
            nibName: "BottomSheetViewController",
            bundle: nil)
        
        container.register(BottomSheetViewModel.self) { _ -> BottomSheetViewModel in
            return BottomSheetViewModel()
        }
        
        container.register(BottomSheetViewController.self) { resolver -> BottomSheetViewController in
            viewController.viewModel = resolver.resolve(BottomSheetViewModel.self)
            viewController.delegate = delegate
            return viewController
        }
    }
    
    func provideFavoriteViewModel(container: Container) {
        let favoriteViewController = FavoriteViewController(
            nibName: "FavoriteViewController",
            bundle: nil)
        container.register(FavoriteRouter.self) { _ -> FavoriteRouter in
            return FavoriteRouter(view: favoriteViewController)
        }
        
        container.register(FavoriteViewModel.self) { resolver -> FavoriteViewModel in
            return FavoriteViewModel(favoriteUseCase: self.provideFavorite(),
                                 router: resolver.resolve(FavoriteRouter.self)!)
        }
        
        container.register(FavoriteViewController.self) { resolver -> FavoriteViewController in
            favoriteViewController.viewModel = resolver.resolve(FavoriteViewModel.self)
            return favoriteViewController
        }
    }
    
}
