//
//  UIColor+.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/09.
//

import Foundation
import UIKit

enum CustomColor {
    case blue
    case gray
    case darkGray
    case boxGray
    case skyblue1
    case skyblue2
    case green
}

extension UIColor {
    
    static func customColor(_ color: CustomColor) -> UIColor {
        switch color {
        case .blue:
            return UIColor(red: 0.00, green: 0.12, blue: 0.37, alpha: 1.00)
        case .gray:
            return UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.00)
        case .darkGray:
            return UIColor(red:0.345, green:0.38, blue:0.467, alpha:1.00)
        case .boxGray:
            return UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1.00)
        case .skyblue1:
            return UIColor(red: 0.89, green: 0.95, blue: 1.00, alpha: 1.00)
        case .skyblue2:
            return UIColor(red: 0.69, green: 0.73, blue: 0.82, alpha: 1.00)
        case .green:
            return UIColor(red: 0.08, green: 0.58, blue: 0.00, alpha: 1.00)

        }
    }
}
