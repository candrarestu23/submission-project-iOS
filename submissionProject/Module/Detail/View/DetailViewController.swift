//
//  DetailViewController.swift
//  submissionProject
//
//  Created by candra restu on 20/05/22.
//

import UIKit
import RxCocoa
import RxSwift
import SDWebImage

class DetailViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var overViewDescLabel: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var viewModel: DetailViewModel?
    var disposeBag = DisposeBag()
    @IBOutlet weak var emptyDataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindData()
        if viewModel?.isFavorite ?? false {
            viewModel?.data.value = viewModel?.localData
            viewModel?.isEmpty.value = true
            viewModel?.isLoading.value = false
        } else {
            viewModel?.getMovieDetail()
            viewModel?.getMovieReview()
        }
        setupTableView()
    }
    
    private func setupViews() {
        cardView.dropShadow()
        loadingView.startAnimating()
        setupFavoriteView()
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTapped(tapGestureRecognizer:))
        )
        favoriteImage.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    private func bindData() {
        viewModel?.data.observe(disposeBag) { [weak self] (data) in
            guard let data = data else { return }
            let imageUrl = URL(string: "\(Constant.BaseImage)\(data.posterPath ?? "")")
            self?.movieImage.sd_setImage(with: imageUrl)
            self?.titleLabel.text = data.title ?? ""
            self?.releaseDateLabel.text = data.releaseDate ?? ""
            self?.overViewDescLabel.text = data.overview ?? ""
            self?.title = data.title ?? ""
        }
        
        viewModel?.reviewData
            .bind(to: reviewTableView.rx.items(
                cellIdentifier: "ReviewCell",
                cellType: ReviewTableViewCell.self)) { _, item, cell in
                    let imageUrl = URL(string: "\(Constant.BaseImage)\(item.authorDetails?.avatarPath ?? "")")
                    cell.userImage.sd_setImage(
                        with: imageUrl,
                        placeholderImage: UIImage(systemName: "person.fill"))
                    cell.userNameLabel.text = item.authorDetails?.username ?? ""
                    cell.reviewLabel.text = item.content ?? ""
                }.disposed(by: disposeBag)
        
        viewModel?.isLoading.observe(disposeBag) { [weak self] isLoading in
            guard let isLoading = isLoading else { return }
            self?.loadingView.isHidden = !isLoading
        }
        
        viewModel?.isEmpty.observe(disposeBag) { [weak self] isEmpty in
            guard let isEmpty = isEmpty else { return }
            self?.emptyDataLabel.isHidden = !isEmpty
        }
        
        viewModel?.isSuccessSave.observe(disposeBag) { [weak self] _ in
            guard let alert = self?.viewModel?.showSaveAlert(
                message: "This movie is now in your favorite"
            ) else { return }
            self?.present(alert, animated: true, completion: nil)
            self?.viewModel?.isFavorite = true
            self?.setupFavoriteView()
        }
        
        viewModel?.isSuccessDelete.observe(disposeBag) { [weak self] _ in
            guard let alert = self?.viewModel?.showSaveAlert(
                message: "This movie is deleted from your favorite"
            ) else { return }
            self?.present(alert, animated: true, completion: nil)
            self?.viewModel?.isFavorite = false
            self?.setupFavoriteView()
        }
    }
    
    private func setupTableView() {
        let nibName = UINib(nibName: "ReviewTableViewCell", bundle: nil)
        reviewTableView.register(nibName, forCellReuseIdentifier: "ReviewCell")
    }
    
    private func setupFavoriteView() {
        if viewModel?.isFavorite ?? false {
            favoriteImage.image = UIImage(systemName: "heart.fill")
        } else {
            favoriteImage.image = UIImage(systemName: "heart")
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if viewModel?.isFavorite ?? false {
            viewModel?.deleteMovies()
        } else {
            viewModel?.saveMovie()
        }
    }
    
}
