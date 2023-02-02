//
//  AddEctImageRequest.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/28.
//

import Foundation
import Moya

struct AddBottomImageRequest: Codable {
    var ectImage: [String:String]
    
    init(ectImage: [String:String]) {
        self.ectImage = ectImage
    }
}
