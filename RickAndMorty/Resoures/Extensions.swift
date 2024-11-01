//
//  Extensions.swift
//  RickAndMorty
//
//  Created by  Ghadi on 25/10/2024.
//

import UIKit

extension UIView {
    /// Add multiple subviews
    /// - Parameter views: Variadic views
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
