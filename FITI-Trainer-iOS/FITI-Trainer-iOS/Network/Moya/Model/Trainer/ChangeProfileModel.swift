//
//  TrainerProfileModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/29.
//

import Foundation

struct ChangeProfileResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
}
