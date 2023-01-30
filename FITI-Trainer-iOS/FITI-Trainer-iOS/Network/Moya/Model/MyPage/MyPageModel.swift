//
//  MyPageModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/29.
//

import Foundation

// MARK: - MyPageResponse
struct MyPageResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: MyPageResult
}

// MARK: - Result
struct MyPageResult: Codable {
    let userIdx: Int
    let userName, profile, email: String
    var location: String? = nil
}
