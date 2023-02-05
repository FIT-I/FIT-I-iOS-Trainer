//
//  FinishMatchingModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/05.
//

import Foundation

struct MatchingSuccessResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [MatchingSuccessResult]
}

// MARK: - Result
struct MatchingSuccessResult: Codable {
    var openChatLink: String? = nil
    let trainerId: Int
    let trainerName: String
    let trainerGrade: Int
    let trainerSchool: String
    let customerId: Int
    let pickUp: String
    var customerLocation: String? = nil
    let createdAt: String
    let matchingId: Int
    let trainerProfile: String
}
