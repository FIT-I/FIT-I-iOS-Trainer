//
//  ChangeBackgroundRequest.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/29.
//

import Foundation

struct ChangeBackgroundRequest: Codable {
    var backgroundImage: String
    
    init(backgroundImage: String) {
        self.backgroundImage = backgroundImage
    }
}
