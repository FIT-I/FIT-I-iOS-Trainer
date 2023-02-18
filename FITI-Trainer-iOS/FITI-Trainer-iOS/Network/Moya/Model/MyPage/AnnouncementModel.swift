//
//  AnnouncementModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/14.
//

import Foundation

// MARK: - Welcome
struct AnnouncementResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    var result: [news]? = nil
}

// MARK: - Result
struct news: Codable {
    var title: String? = nil
    var contents: String? = nil
    var createdAt: String? = nil
}

