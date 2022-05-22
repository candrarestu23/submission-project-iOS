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

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: HomeViewModel?
    var disposeBag = DisposeBag()
    
    lazy var spinner = UIActivityIndicatorView(
        frame:CGRect(x: 0,
                     y: 0,
                     width: self.tableView.frame.width,
                     height: 60)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavBar()
        bindData()
        viewModel?.getMovies()
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
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTapped(tapGestureRecognizer:))
        )
        
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        let item = UIBarButtonItem(customView: imageView)
        self.navigationItem.rightBarButtonItem = item
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
                           let page = self?.viewModel?.page.value,
                           page > 1 {
                            self?.viewModel?.getMovies()
                        }
                    }
                }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel?
                    .onItemListSelected(
                        id: self?.viewModel?.dataList[indexPath.row].movieID ?? 0
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
//            self.emptyListLabel.isHidden = !isEmpty
        }
    }
    
    @IBAction func onCategoryClick(_ sender: Any) {
        viewModel?.onCategorySelecter(delegate: self)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        viewModel?.onFavoriteSelected()
    }
}

extension HomeViewController: BottomSheetDelegate {
    func onItemSelected(type: String) {
        viewModel?.type.value = type
        viewModel?.data.accept([])
        viewModel?.dataList.removeAll()
        viewModel?.getMovies()
    }
}
