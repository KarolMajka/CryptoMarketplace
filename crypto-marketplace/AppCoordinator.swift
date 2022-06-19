//
//  AppCoordinator.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import UIKit

final class AppCoordinator: Coordinator {

    var rootController: UIViewController?
    var presentation: CoordinatorPresentation {
        return dependencies.presentation
    }

    struct Dependencies {
        let presentation: CoordinatorPresentation
    }
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func start() {
        let viewModel = CryptoMarketplaceViewModel()
        let viewController = CryptoMarketplaceViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        present(viewController: navigationController)
    }
}
