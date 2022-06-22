//
//  Shadow.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 22/06/2022.
//

import UIKit

enum Elevation {
    case small

    private var values: Values {
        switch self {
        case .small:
            return Values(x: 0, y: 2, alpha: 0.08, radius: 4)
        }
    }

    func apply(on view: UIView, cornerRadius: CGFloat? = nil) {
        let values = self.values

        view.layer.shadowColor = UIColor.shadow.cgColor
        view.layer.shadowRadius = values.radius
        view.layer.shadowOffset = values.offset
        view.layer.shadowOpacity = values.alpha
    }
}

extension Elevation {
    private struct Values {
        let x: CGFloat
        let y: CGFloat
        let alpha: Float
        let radius: CGFloat

        var offset: CGSize {
            .init(width: x, height: y)
        }
    }
}
