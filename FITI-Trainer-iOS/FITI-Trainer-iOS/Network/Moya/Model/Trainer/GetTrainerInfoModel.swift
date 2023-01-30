//
//  GetTrainerInfoModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/30.
//

import Foundation

// MARK: - PolicyResponse
struct GetTrainerInfoResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: User
}

// MARK: - Result
struct User: Codable {
    let name, profile, background, levelName: String
    let school: String
    let grade: Double
    let cost: Int
    let intro, service, reviewDto, imageList: String
}
