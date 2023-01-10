//
//  UIStackView+.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/09.
//
import Foundation
import UIKit.UIStackView

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
