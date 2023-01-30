//
//  String+.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/30.
//

import Foundation
import UIKit

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
