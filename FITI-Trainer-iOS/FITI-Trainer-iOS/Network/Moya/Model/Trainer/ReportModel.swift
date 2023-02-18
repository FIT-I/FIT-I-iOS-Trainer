//
//  ReportModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/14.
//

import Foundation

struct ReportResponse: Codable {
    let isSuccess: Bool
    let code: Int
    var message: String? = nil
    var result: String? = nil
}
