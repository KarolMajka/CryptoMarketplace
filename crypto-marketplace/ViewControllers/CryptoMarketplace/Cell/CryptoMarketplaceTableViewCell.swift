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
        label.textColor = .primaryText
        label.font = .heading
        return label
    }()
    private let rightCoinLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textColor = .secondaryText
        label.font = .body
        return label
    }()
    private let lastPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryText
        label.font = .subheading
        label.textAlignment = .right
        return label
    }()
    private let priceChangeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .xxxs
        Elevation.small.apply(on: view)
        return view
    }()
    private let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .neutralWhite
        label.font = .subheading
        label.textAlignment = .center
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
        mainStackView.spacing = .s

        contentView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(CGFloat.s)
            $0.top.bottom.equalToSuperview().inset(CGFloat.xxs)
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
        coinsStackView.spacing = .xxxs

        return coinsStackView
    }
}
