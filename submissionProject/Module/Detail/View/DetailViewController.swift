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
import Detail
import Core

class DetailViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieTimeLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieDescLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    var viewModel: MovieDetailViewModel<DetailInteractor<URLRequest,
                                                         MovieDetailModel,
                                                         MovieReviewModel,
                                                         CastListModel,
                                                         GetMovieDetailRepository<GetMovieDetailDataSource,
                                                                                  GetMovieReviewDataSource,
                                                                                  GetMovieCastDataSource,
                                                                                  GetMovieDetailLocaldataSource,
                                                                                  MovieDetailTransformer,
                                                                                  MovieReviewTransformer,
                                                         CastListTransformer>>>?
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindData()
        viewModel?.getCastList(
            urlRequst: MoviesAPI.getCast(self.viewModel?.movieID ?? 0).urlRequest
        )
        viewModel?.getMovieDetail(
            urlRequest: MoviesAPI.getMovieDetail(self.viewModel?.movieID ?? 0).urlRequest
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupTableView() {
        let nibName = UINib(nibName: "CastItemCollectionViewCell", bundle: nil)
        castCollectionView.register(nibName, forCellWithReuseIdentifier: "CastCell")
    }
    
    private func bindData() {
        viewModel?.castListdata
            .bind(to:castCollectionView.rx.items(
                cellIdentifier: "CastCell",
                cellType: CastItemCollectionViewCell.self)) { index, item, cell in
                    let imageUrl = URL(string: "\(Constant.BaseImage)\(item.profilePath ?? "")")
                    cell.castImage.sd_setImage(with: imageUrl)
                    cell.castImage.layer.cornerRadius = 40
                    cell.castNameLabel.text = item.name ?? ""
                }.disposed(by: disposeBag)
        
        viewModel?.data.observe(disposeBag) { [weak self] (data) in
            guard let data = data else { return }
            let imageUrl = URL(string: "\(Constant.BaseImage)\(data.posterPath ?? "")")
            self?.movieImage.sd_setImage(with: imageUrl)
            self?.movieTitleLabel.text = data.title ?? ""
            self?.movieTimeLabel.text = self?.viewModel?.convertRunTime(runtime: data.runtime ?? 0)
            self?.movieGenreLabel.text = self?.viewModel?.combineGenre(genre: data.genres ?? [])
            self?.movieDescLabel.text = data.overview ?? ""
            self?.title = data.title ?? ""
        }
        
        viewModel?.isLoading.observe(disposeBag) { isLoading in
            guard let isLoading = isLoading else { return }

            if isLoading {
                LoadingOverlay.shared.showLoading()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    LoadingOverlay.shared.dismissLoading()
                }
            }
        }
        
        viewModel?.isEmpty.observe(disposeBag) { [weak self] isEmpty in
            guard let isEmpty = isEmpty else { return }
        }
        
        viewModel?.errorMessage.observe(disposeBag) { [weak self] errorMessage in
            guard let errorMessage = errorMessage else {
                return
            }
            
        }
        
        viewModel?.isSuccessSave.observe(disposeBag) { [weak self] _ in
            guard let alert = self?.viewModel?.showSaveAlert(
                message: "This movie is now in your favorite"
            ) else { return }
            self?.present(alert, animated: true, completion: nil)
            self?.viewModel?.isFavorite = true
        }
        
        viewModel?.isSuccessDelete.observe(disposeBag) { [weak self] _ in
            guard let alert = self?.viewModel?.showSaveAlert(
                message: "This movie is deleted from your favorite"
            ) else { return }
            self?.present(alert, animated: true, completion: nil)
            self?.viewModel?.isFavorite = false
        }
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
