//
//  CryptoMarketplaceTableViewCell.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import UIKit

final class CryptoMarketplaceTableViewCell: UITableViewCell {

    private let leftCoinLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    private let rightCoinLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textColor = .init(light: .darkGray, dark: .lightGray)
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    private let lastPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    private let priceChangeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.shadowColor = UIColor(light: .black, dark: .white).cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowOpacity = 0.08
        return view
    }()
    private let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    private var viewModel: CryptoMarketplaceCellViewModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(withViewModel viewModel: CryptoMarketplaceCellViewModel) {
        self.viewModel = viewModel

        leftCoinLabel.text = viewModel.output.cell.leftCoinText
        rightCoinLabel.text = viewModel.output.cell.rightCoinText
        lastPriceLabel.text = viewModel.output.cell.lastPriceText
        lastPriceLabel.textColor = viewModel.output.cell.lastPriceColor.textColor
        priceChangeLabel.text = viewModel.output.cell.priceChangeText
        priceChangeView.backgroundColor = viewModel.output.cell.priceChangeColor.backgroundColor
    }

    private func prepareViews() {
        selectionStyle = .none
        prepareMainStackView()
    }

    private func prepareMainStackView() {
        let mainStackView = UIStackView(arrangedSubviews: [
            prepareCoinsStackView(),
            lastPriceLabel,
            prepareDailyChangeRelativeView(),
        ])
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.spacing = 16

        contentView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }

    private func prepareDailyChangeRelativeView() -> UIView {
        priceChangeView.addSubview(priceChangeLabel)
        priceChangeLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        priceChangeView.snp.makeConstraints {
            $0.height.equalTo(45)
            $0.width.equalTo(100)
        }

        return priceChangeView
    }

    private func prepareCoinsStackView() -> UIStackView {
        let coinsStackView = UIStackView(arrangedSubviews: [
            leftCoinLabel,
            rightCoinLabel,
        ])
        coinsStackView.axis = .horizontal
        coinsStackView.alignment = .lastBaseline
        coinsStackView.spacing = 4

        return coinsStackView
    }
}
