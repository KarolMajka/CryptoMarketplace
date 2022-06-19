//
//  Coordinator.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import UIKit

enum CoordinatorPresentation {
    case push(navigationController: UINavigationController)
    case present(presentingController: UIViewController)
    case window(window: UIWindow, transition: CATransition?)
}

protocol Coordinator: AnyObject {
    var presentation: CoordinatorPresentation { get }
    var rootController: UIViewController? { get set }

    func start()
}

extension Coordinator {
    var rootNavigationController: UINavigationController? {
        return rootController as? UINavigationController ?? rootController?.navigationController
    }
}


// MARK: - Presentation
extension Coordinator {
    func present(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        rootController = viewController

        switch presentation {
        case .present(let presentingController):
            presentingController.present(viewController, animated: animated, completion: completion)
        case .push(let navigationController):
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            if let navigationControllerToPush = viewController as? UINavigationController, let topViewController = navigationControllerToPush.topViewController {
                rootController = topViewController
                navigationController.pushViewController(topViewController, animated: animated)
            } else {
                navigationController.pushViewController(viewController, animated: animated)
            }
            CATransaction.commit()

        case let .window(window, transition):
            window.setRootViewController(viewController, transition: transition)
            window.makeKeyAndVisible()
            completion?()
        }
    }

    func finish(animated: Bool = true, completion: (() -> Void)? = nil) {
        switch presentation {
        case .present:
            rootController?.dismiss(animated: animated, completion: completion)
        case .push(let navigationController):
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            if let indexOfRootController = navigationController.viewControllers.firstIndex(where: { $0 === rootController }),
                let toViewController = navigationController.viewControllers[safe: indexOfRootController - 1] {
                navigationController.popToViewController(toViewController, animated: animated)
            } else if let rootController = rootController {
                navigationController.popToViewController(rootController, animated: true)
            } else {
                navigationController.popViewController(animated: animated)
            }
            CATransaction.commit()
        case .window(let window, _):
            window.removeFromSuperview()
            completion?()
        }
    }
}
