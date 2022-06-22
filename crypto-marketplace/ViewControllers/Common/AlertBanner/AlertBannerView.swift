//
//  AlertBannerView.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 21/06/2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class AlertBannerView: UIView {

    private static let animationDuration: TimeInterval = 0.2

    private let disposeBag = DisposeBag()

    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setErrorMessage(_ errorMessage: String?) {
        errorMessageLabel.text = errorMessage
    }

    func addToViewController(_ viewController: UIViewController) {
        viewController.view.addSubview(self)
        if let navigationBar = viewController.navigationController?.navigationBar {
            snp.makeConstraints {
                $0.left.right.equalTo(navigationBar.safeAreaLayoutGuide)
                $0.top.equalTo(navigationBar.safeAreaLayoutGuide.snp.bottom)
            }
        } else {
            snp.makeConstraints {
                $0.left.right.top.equalTo(viewController.view.safeAreaLayoutGuide)
            }
        }
    }

    func present() {
        animate(alpha: 1)
    }

    func dismiss() {
        animate(alpha: 0)
    }

    private func animate(alpha: CGFloat) {
        guard self.alpha != alpha else { return }
        UIView.animate(
            withDuration: AlertBannerView.animationDuration,
            delay: 0,
            options: .curveEaseIn,
            animations: { [weak self] in
                self?.alpha = alpha
            },
            completion: nil
        )
    }

    private func prepareViews() {
        alpha = 0
        backgroundColor = .init(red: 227/255, green: 84/255, blue: 97/255, alpha: 1)

        addSubview(errorMessageLabel)
        errorMessageLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.top.equalToSuperview().inset(4)
        }
    }
}
