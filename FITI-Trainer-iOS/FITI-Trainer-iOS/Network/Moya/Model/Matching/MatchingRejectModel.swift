//
//  MatchingRejectModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/04.
//

import Foundation

struct MatchingRejectResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message, result: String
}
