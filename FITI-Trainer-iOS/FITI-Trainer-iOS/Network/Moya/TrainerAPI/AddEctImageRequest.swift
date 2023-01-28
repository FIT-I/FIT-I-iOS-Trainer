//
//  AddEctImageRequest.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/28.
//

import Foundation

struct AddEctImageRequest: Codable {
    var ectImage: [String]
    
    init(ectImage: [String]) {
        self.ectImage = ectImage
    }
}
