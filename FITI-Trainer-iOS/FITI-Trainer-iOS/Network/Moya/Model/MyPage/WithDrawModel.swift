//
//  WithDrawModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/13.
//

import Foundation

struct WithDrawResponse: Codable {
    var isSuccess: Bool? = false
    var code: Int? = nil
    var message: String? = nil
    var result: String? = nil
}
