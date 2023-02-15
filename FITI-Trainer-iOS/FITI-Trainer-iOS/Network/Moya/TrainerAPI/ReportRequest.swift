//
//  ReportRequest.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/14.
//

import Foundation

struct ReportRequest: Codable {
    var customerId: Int
    var reason : String? = nil
    
    init(customerId: Int, reason: String? = nil) {
        self.customerId = customerId
        self.reason = reason
    }
}
