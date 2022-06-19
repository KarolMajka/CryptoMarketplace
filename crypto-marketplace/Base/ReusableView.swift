//
//  ReusableView.swift
//  crypto-marketplace
//
//  Created by Karol Majka on 19/06/2022.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

extension UITableViewCell: ReusableView { }
extension UITableViewHeaderFooterView: ReusableView { }
