//
//  UICollectionView+.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/24.
//

import Foundation
import UIKit.UICollectionView

extension UICollectionView {
    func lastIndexpath() -> IndexPath {
            let section = max(numberOfSections - 1, 0)
            let row = max(numberOfItems(inSection: section) - 1, 0)
            
            return IndexPath(row: row, section: section)
        }
}

