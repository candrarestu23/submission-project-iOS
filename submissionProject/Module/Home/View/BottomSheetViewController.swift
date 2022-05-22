//
//  BottomSheetViewController.swift
//  submissionProject
//
//  Created by candra restu on 21/05/22.
//

import UIKit
import RxSwift
import RxCocoa

protocol BottomSheetDelegate: AnyObject {
    func onItemSelected(type: String)
}

class BottomSheetViewController: UIViewController {

    var viewModel: BottomSheetViewModel?
    var disposeBag = DisposeBag()
    var delegate: BottomSheetDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.setupData()
        setupTableView()
        bindData()
    }
    
    private func bindData() {
        viewModel?.data
            .bind(to:tableView.rx.items(
                cellIdentifier: "CategoryCell",
                cellType: CategoryTableViewCell.self)) { _, item, cell in
                    cell.nameLabel.text = item
                }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.dismiss(animated: true) {
                    self?.delegate?.onItemSelected(
                        type: self?.viewModel?.categoryID[indexPath.row] ?? ""
                    )
                }
            }).disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        let nibName = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "CategoryCell")
    }
}
