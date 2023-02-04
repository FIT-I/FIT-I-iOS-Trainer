//
//  MatchingRejectModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/04.
//

import Foundation

struct MatchingRejectResponse: Codable {
    var isSuccess: Bool? = nil
    var code: Int? = nil
    var message: String? = nil
    var result: String? = nil
}
