//
//  ChangeCategoryRequest.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/01.
//

import Foundation

struct ChangeCategoryRequest: Codable {
    var category: String
    
    init(category: String) {
        self.category = category
    }
}
