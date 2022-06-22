//
//  CryptoMarketplaceViewController.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import UIKit
import SnapKit
import KeyboardLayoutGuide
import RxSwift

final class CryptoMarketplaceViewController: UIViewController {

    private let tableView = UITableView()
    private let activityIndicatorView = UIActivityIndicatorView()
    private let searchController = UISearchController()
    private let alertBannerView = AlertBannerView()

    private let disposeBag = DisposeBag()
    private let viewModel: CryptoMarketplaceViewModel

    init(viewModel: CryptoMarketplaceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
        prepareRxObservers()
        viewModel.input.view.fetchData.onNext(())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if alertBannerView.superview == nil {
            alertBannerView.addToViewController(self)
        }
    }

    private func prepareViews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = L10n.CryptoMarketplace.viewTitle
        navigationItem.searchController = searchController

        tableView.contentInset.bottom = .xxs
        tableView.contentInset.top = .l
        tableView.register(CryptoMarketplaceTableViewCell.self)
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.left.right.top.equalToSuperview()
            $0.bottom.equalTo(view.keyboardLayoutGuideNoSafeArea.snp.top)
        }

        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func prepareRxObservers() {
        viewModel.output.view.cellViewModels
            .drive(tableView.rx.items) { tableView, row, cellViewModel in
                let indexPath = IndexPath(row: row, section: 0)
                switch cellViewModel {
                case let cellViewModel as CryptoMarketplaceCellViewModel:
                    let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CryptoMarketplaceTableViewCell
                    cell.configure(withViewModel: cellViewModel)
                    return cell
                default:
                    print("Unhandled CellViewModel type: \(cellViewModel.self).")
                    return UITableViewCell()
                }
            }
            .disposed(by: disposeBag)

        viewModel.output.view.activityIndicator
            .drive(activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)

        viewModel.output.view.errorMessage
            .drive(with: self, onNext: { (self, errorMessage) in
                if let errorMessage = errorMessage {
                    self.alertBannerView.setErrorMessage(errorMessage)
                    self.alertBannerView.present()
                } else {
                    self.alertBannerView.dismiss()
                }
            })
            .disposed(by: disposeBag)

        searchController.searchBar.rx.text
            .bind(to: viewModel.input.view.searchText)
            .disposed(by: disposeBag)
    }
}
