//
//  NoticeModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/29.
//

import Foundation

// MARK: - NoticeResponse
struct NoticeResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [NoticeResult]
}

// MARK: - Result
struct NoticeResult: Codable {
    let title, contents, createdAt: String
}
