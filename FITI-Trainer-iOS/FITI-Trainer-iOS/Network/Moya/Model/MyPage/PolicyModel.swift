//
//  PolicyModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/29.
//

import Foundation

// MARK: - PolicyResponse
struct PolicyResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [PolicyResult]
}

// MARK: - Result
struct PolicyResult: Codable {
    let termIdx: Int
    let termName, termDetail: String
}
