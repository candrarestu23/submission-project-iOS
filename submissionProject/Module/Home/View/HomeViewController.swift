//
//  HomeViewController.swift
//  submissionProject
//
//  Created by candra restu on 19/05/22.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import Home
import Core

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: HomeViewModel<HomeInteractor<MovieListModel,
                                                    URLRequest,
                                                    GetMovieListRepository<GetMoviesDataSource,
                                                                            GetMovieListLocaldataSource,
                                                                            MovieListTransformer>>>?
    var router: HomeRouter?
    var disposeBag = DisposeBag()
    
    lazy var spinner = UIActivityIndicatorView(
        frame:CGRect(x: 0,
                     y: 0,
                     width: self.tableView.frame.width,
                     height: 60)
    )
    
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0,
                                                               y: 0,
                                                               width: Int(UIScreen.main.bounds.width) - 40,
                                                               height: 70))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavBar()
        bindData()
        viewModel?.getMovies(
            urlRequest: MoviesAPI.getMovies(viewModel?.page ?? 1,
                                            "popular").urlRequest
        )
    }
    
    private func setupTableView() {
        let nibName = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HomeCell")
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: self.tableView.frame.width,
                                        height: 60)
        )

        spinner.startAnimating()
        view.addSubview(spinner)
        tableView.tableFooterView = view
    }
    
    private func setupNavBar() {
        self.title = "Home"
        searchBar.placeholder = "Search Movie"
        searchBar.delegate = self
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    private func bindData() {
        viewModel?.data
            .bind(to:tableView.rx.items(
                cellIdentifier: "HomeCell",
                cellType: HomeTableViewCell.self)) { [weak self] index, item, cell in
                    let imageUrl = URL(string: "\(Constant.BaseImage)\(item.posterPath ?? "")")
                    cell.movieImage.sd_setImage(with: imageUrl)
                    cell.titleLabel.text = item.title
                    cell.releaseDateLabel.text = item.releaseDate
                    cell.overviewLabel.text = item.overview
                    if index == (self?.viewModel?.data.value.count ?? 0) - 1 {
                        if let isLoading = self?.viewModel?.isLoading,
                           isLoading.value == false,
                           let page = self?.viewModel?.page,
                           page > 1 {
                            if let keyword = self?.viewModel?.searchKeyword {
                                if keyword.isEmpty {
                                    self?.viewModel?.getMovies(
                                        urlRequest: MoviesAPI.getMovies(
                                            self?.viewModel?.page ?? 1, "popular"
                                        ).urlRequest
                                    )
                                } else {
                                    self?.viewModel?.getSearchMovies(
                                        urlRequest: MoviesAPI.getSearchMovie(self?.viewModel?.searchKeyword ?? "",
                                                                             self?.viewModel?.page ?? 1).urlRequest
                                    )
                                }
                            }
                        }
                    }
                }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.router?.routeToDetailPage(
                    self?.viewModel?.dataList.at(index: indexPath.row)?.movieID ?? 0
                )
            }).disposed(by: disposeBag)
        
        viewModel?.isLoading.observe(disposeBag) { [weak self] (isLoading) in
            guard let isLoading = isLoading else {
                return
            }

            if isLoading {
                self?.spinner.startAnimating()
            } else {
                self?.spinner.stopAnimating()
            }
        }
        
        viewModel?.isEmpty.observe(disposeBag) { (isEmpty) in
            guard let isEmpty = isEmpty else {
                return
            }
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel?.dataList.removeAll()
        self.viewModel?.data.accept(viewModel?.dataList ?? [])
        self.viewModel?.page = 1
        self.viewModel?.removeAllCache()
        self.viewModel?.searchKeyword = searchBar.text ?? ""
        if !(searchBar.text ?? "").isEmpty {
            self.viewModel?.getSearchMovies(
                urlRequest: MoviesAPI.getSearchMovie(self.viewModel?.searchKeyword ?? "",
                                                     self.viewModel?.page ?? 1).urlRequest
            )
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel?.dataList.removeAll()
        self.viewModel?.data.accept(viewModel?.dataList ?? [])
        self.viewModel?.page = 1
        self.viewModel?.removeAllCache()
        self.viewModel?.getMovies(
            urlRequest: MoviesAPI.getMovies(self.viewModel?.page ?? 1, "popular").urlRequest
        )
    }
}
