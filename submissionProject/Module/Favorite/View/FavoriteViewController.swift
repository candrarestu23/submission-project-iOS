//
//  FavoriteViewController.swift
//  submissionProject
//
//  Created by candra restu on 21/05/22.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    
    var viewModel: FavoriteViewModel?
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindData()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getMovies()
    }
    
    private func setupTableView() {
        let nibName = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HomeCell")
    }
    
    private func setupNavBar() {
        self.title = "Favorite"
    }
    
    private func bindData() {
        viewModel?.data
            .bind(to:tableView.rx.items(
                cellIdentifier: "HomeCell",
                cellType: HomeTableViewCell.self)) { _, item, cell in
                    let imageUrl = URL(string: "\(Constant.BaseImage)\(item.posterPath ?? "")")
                    cell.movieImage.sd_setImage(with: imageUrl)
                    cell.titleLabel.text = item.title
                    cell.releaseDateLabel.text = item.releaseDate
                    cell.overviewLabel.text = item.overview
                }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                if let data = self?.viewModel?.data.value[indexPath.row] {
                    self?.viewModel?
                        .onItemSelected(data: data)
                }
            }).disposed(by: disposeBag)
        
        viewModel?.isLoading.observe(disposeBag) { isLoading in
            guard let isLoading = isLoading else {
                return
            }
        }
        
        viewModel?.isEmpty.observe(disposeBag) { [weak self] (isEmpty) in
            guard let isEmpty = isEmpty else {
                return
            }
            self?.noDataLabel.isHidden = !isEmpty
        }
    }
}
