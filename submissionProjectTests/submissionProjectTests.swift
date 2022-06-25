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
@testable import Home
@testable import Core
@testable import Detail
@testable import submissionProject

class submissionProjectTests: XCTestCase {

    var homeViewModel: HomeViewModel<HomeInteractor<MovieListModel,
                                                    URLRequest,
                                                    GetMovieListRepository<MockMovieDataSource,
                                                                            MockLocalDataSource,
                                                                            MovieListTransformer>>>!
    
    var detailViewModel: MovieDetailViewModel<DetailInteractor<URLRequest,
                                                               MovieDetailModel,
                                                               MovieReviewModel,
                                                               CastListModel,
                                                               GetMovieDetailRepository<MockDetailDataSource,
                                                                                        MockReviewDataSource,
                                                                                        MockCastDataSource,
                                                                                        MockLocalDataSource,
                                                                                        MovieDetailTransformer,
                                                                                        MovieReviewTransformer,
                                                                                        CastListTransformer>>>!
    var container: Container!
    var realm: Realm!
    
    override func setUp() {
        self.container = Container()
        realm = try! Realm()
        setupHomeController()
        setupDetailController()
    }
    
    private func setupHomeController() {
        let homeController = HomeViewController(
            nibName: "HomeViewController",
            bundle: nil)
        
        container.register(HomeRouter.self) { _ -> HomeRouter in
            return HomeRouter(view: homeController)
        }
        
        container.register(HomeViewModel<HomeInteractor<MovieListModel, URLRequest, GetMovieListRepository<MockMovieDataSource, MockLocalDataSource, MovieListTransformer>>>.self) { resolver -> HomeViewModel in
            let remote = MockMovieDataSource()
            let local = MockLocalDataSource(realm: self.realm)
            let mapper = MovieListTransformer()
            let repository = GetMovieListRepository(remoteDataSource: remote,
                                                    localDataSource: local,
                                                    transformer: mapper)
            let interactor = HomeInteractor(repository: repository)
            return HomeViewModel(homeUseCase: interactor)
        }
        
        container.register(HomeViewController.self) { resolver -> HomeViewController in
            homeController.viewModel = resolver.resolve(HomeViewModel.self)
            return homeController
        }
    }
    
    private func setupDetailController() {
        let viewController = DetailViewController(nibName: "DetailViewController",
                                                      bundle: nil)
        
        container.register(MovieDetailViewModel<DetailInteractor<URLRequest, MovieDetailModel, MovieReviewModel, CastListModel, GetMovieDetailRepository<MockDetailDataSource, MockReviewDataSource, MockCastDataSource, MockLocalDataSource, MovieDetailTransformer, MovieReviewTransformer, CastListTransformer>>>.self) { resolver -> MovieDetailViewModel in
            let remoteDetail = MockDetailDataSource()
            let remoteReview = MockReviewDataSource()
            let remoteCast = MockCastDataSource()
            let local = MockLocalDataSource(realm: self.realm)
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
            return MovieDetailViewModel(detailUseCase: interactor, movieID: 1, isFavorite: false, movieData: nil)
        }

        container.register(DetailViewController.self) { resolver -> DetailViewController in
            viewController.viewModel = resolver.resolve(MovieDetailViewModel.self)
            return viewController
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
        homeViewModel.getMovies(urlRequest: MoviesAPI.getMovies(1, "").urlRequest)
        XCTAssert(homeViewModel.dataList.count > 0)
    }
    
    func test_home_movie_list_data() {
        homeViewModel = container.resolve(HomeViewModel.self)
        homeViewModel.getMovies(urlRequest: MoviesAPI.getMovies(1, "").urlRequest)
        XCTAssert(homeViewModel.dataList.at(index: 0)?.title == "The Lost City")
        XCTAssert(homeViewModel.dataList.at(index: 1)?.title == "Sonic the Hedgehog 2")
        XCTAssert(homeViewModel.dataList.at(index: 0)?.movieID == 752623)
        XCTAssert(homeViewModel.dataList.at(index: 1)?.movieID == 675353)
    }
    
    func test_home_get_search_movie() {
        homeViewModel = container.resolve(HomeViewModel.self)
        homeViewModel.getSearchMovies(urlRequest: MoviesAPI.getSearchMovie("", 1).urlRequest)
        XCTAssert(homeViewModel.dataList.count > 0)
    }
    
    func test_detail_get_movie() {
        detailViewModel = container.resolve(MovieDetailViewModel.self)
        detailViewModel.getMovieDetail(urlRequest: MoviesAPI.getMovieDetail(1).urlRequest)
        XCTAssertTrue(detailViewModel.data.value != nil)
    }
    
    func test_detail_get_data() {
        detailViewModel = container.resolve(MovieDetailViewModel.self)
        detailViewModel.getMovieDetail(urlRequest: MoviesAPI.getMovieDetail(1).urlRequest)
        XCTAssert((detailViewModel.data.value?.movieID ?? 0) == 675353)
    }
    
    func test_detail_get_review() {
        detailViewModel = container.resolve(MovieDetailViewModel.self)
        detailViewModel.getMovieReview(urlRequest: MoviesAPI.getMovieReview(1).urlRequest)
        XCTAssertTrue(detailViewModel.reviewData.value != nil)
    }
    
    func test_detail_review_data() {
        detailViewModel = container.resolve(MovieDetailViewModel.self)
        detailViewModel.getMovieReview(urlRequest: MoviesAPI.getMovieReview(1).urlRequest)
        XCTAssertTrue(detailViewModel.reviewData.value.at(index: 0)?.id == "624abbe2d9f4a60063674455")
    }
    
    func test_detail_get_cast() {
        detailViewModel = container.resolve(MovieDetailViewModel.self)
        detailViewModel.getCastList(urlRequst: MoviesAPI.getCast(0).urlRequest)
        XCTAssertTrue(detailViewModel.castListdata.value.count > 0)
    }
    
    func test_detail_cast_data() {
        detailViewModel = container.resolve(MovieDetailViewModel.self)
        detailViewModel.getCastList(urlRequst: MoviesAPI.getCast(1).urlRequest)
        XCTAssertTrue(detailViewModel.castListdata.value.at(index: 0)?.id == 71580)
    }
    
    func test_detail_convert_time() {
        detailViewModel = container.resolve(MovieDetailViewModel.self)
        let convertedTime = detailViewModel.convertRunTime(runtime: 120)
        XCTAssertTrue(convertedTime == "2h")
    }
    
    func test_detail_convert_time_2() {
        detailViewModel = container.resolve(MovieDetailViewModel.self)
        let convertedTime = detailViewModel.convertRunTime(runtime: 130)
        XCTAssertTrue(convertedTime == "2h 10m")
    }
    
    func test_detail_combined_genre() {
        detailViewModel = container.resolve(MovieDetailViewModel.self)
        detailViewModel.getMovieDetail(urlRequest: MoviesAPI.getMovieDetail(1).urlRequest)
        let combinedGenre = detailViewModel.combineGenre(genre: detailViewModel.data.value?.genres ?? [])
        XCTAssert(!combinedGenre.isEmpty)
        XCTAssert(combinedGenre == "Action, Science Fiction, Comedy, Family, Adventure, ")
    }
}
