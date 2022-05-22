//
//  submissionProjectTests.swift
//  submissionProjectTests
//
//  Created by candra restu on 22/05/22.
//

import XCTest
import RxSwift
import Swinject
import RealmSwift
@testable import submissionProject

class submissionProjectTests: XCTestCase {

    var homeViewModel: HomeViewModel!
    var detailViewModel: DetailViewModel!
    var favoriteViewModel: FavoriteViewModel!
    var container: Container!
    var realm: Realm!
    
    override func setUp() {
        self.container = Container()
        realm = try! Realm()
        
        setupHomeController()
        setupDetailController()
        setupFavoriteController()
    }
    
    private func setupHomeController() {
        let homeController = HomeViewController(
            nibName: "HomeViewController",
            bundle: nil)
        
        container.register(HomeRouter.self) { _ -> HomeRouter in
            return HomeRouter(view: homeController)
        }
        
        container.register(HomeViewModel.self) { resolver -> HomeViewModel in
            let remote = MockMovieDataSource()
            let local = MockLocalDataSource(realm: self.realm)
            let repository = MockMovieRepository(locale: local, remote: remote)
            let interactor = HomeInteractor(repository: repository)
            let router = resolver.resolve(HomeRouter.self)
            return HomeViewModel(homeUseCase: interactor, router: router)
        }
    }
    
    private func setupDetailController() {
        let detailController = DetailViewController(
            nibName: "DetailViewController",
            bundle: nil)
        
        container.register(DetailRouter.self) { _ -> DetailRouter in
            return DetailRouter(view: detailController)
        }
        
        container.register(DetailViewModel.self) { resolver -> DetailViewModel in
            let remote = MockMovieDataSource()
            let local = MockLocalDataSource(realm: self.realm)
            let repository = MockMovieRepository(locale: local, remote: remote)
            let interactor = DetailInteractor(repository: repository)
            return DetailViewModel(
                detailUseCase: interactor,
                movieID: 0,
                isFavorite: false,
                movieData: nil)
        }
    }
    
    private func setupFavoriteController() {
        let favoriteController = FavoriteViewController(
            nibName: "FavoriteViewController",
            bundle: nil)
        
        container.register(FavoriteRouter.self) { _ -> FavoriteRouter in
            return FavoriteRouter(view: favoriteController)
        }
        
        container.register(FavoriteViewModel.self) { resolver -> FavoriteViewModel in
            let remote = MockMovieDataSource()
            let local = MockLocalDataSource(realm: self.realm)
            let repository = MockMovieRepository(locale: local, remote: remote)
            let interactor = FavoriteInteractor(repository: repository)
            let router = resolver.resolve(FavoriteRouter.self)
            return FavoriteViewModel(favoriteUseCase: interactor, router: router)
        }
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_home_get_movie_list() {
        homeViewModel = container.resolve(HomeViewModel.self)
        
        homeViewModel.getMovies()
        XCTAssert(homeViewModel.dataList.count > 0)
    }

    func test_home_saved_data() {
        homeViewModel = container.resolve(HomeViewModel.self)
        homeViewModel.getMovies()
        XCTAssert(homeViewModel.dataList.at(index: 0)?.title == "The Lost City")
        XCTAssert(homeViewModel.dataList.at(index: 0)?.releaseDate == "2022-03-24")
        XCTAssert(homeViewModel.dataList.at(index: 0)?.posterPath == "/neMZH82Stu91d3iqvLdNQfqPPyl.jpg")
    }
    
    func test_home_saved_data_2() {
        homeViewModel = container.resolve(HomeViewModel.self)
        homeViewModel.getMovies()
        XCTAssert(homeViewModel.dataList.at(index: 1)?.title == "Sonic the Hedgehog 2")
        XCTAssert(homeViewModel.dataList.at(index: 1)?.releaseDate == "2022-03-30")
        XCTAssert(homeViewModel.dataList.at(index: 1)?.posterPath == "/6DrHO1jr3qVrViUO6s6kFiAGM7.jpg")
    }
    
    func test_detail_get_movies() {
        detailViewModel = container.resolve(DetailViewModel.self)
        detailViewModel.getMovieDetail()
        XCTAssert(detailViewModel.data.value?.title == "Sonic the Hedgehog 2")
        XCTAssert(detailViewModel.data.value?.releaseDate == "2022-03-30")
        XCTAssert(detailViewModel.data.value?.posterPath == "/6DrHO1jr3qVrViUO6s6kFiAGM7.jpg")
     }
    
    func test_detail_get_reviews() {
        detailViewModel = container.resolve(DetailViewModel.self)
        detailViewModel.getMovieReview()
        XCTAssert(detailViewModel.reviewData.value.at(index: 0)?
                    .authorDetails?.username == "Geronimo1967")
        XCTAssert(detailViewModel.reviewData.value.at(index: 0)?
                    .authorDetails?.avatarPath == "/1kks3YnVkpyQxzw36CObFPvhL5f.jpg")
        XCTAssert(detailViewModel.reviewData.value.at(index: 0)?
                    .content != nil)
    }
    
    func test_favorite_get_list() {
        detailViewModel = container.resolve(DetailViewModel.self)
        detailViewModel.getMovieDetail()
        detailViewModel.saveMovie()
        favoriteViewModel = container.resolve(FavoriteViewModel.self)
        favoriteViewModel.getMovies()
        print(favoriteViewModel.data.value)
        XCTAssert(favoriteViewModel.data.value.at(index: 0)?.title == "Sonic the Hedgehog 2")
    }
}
