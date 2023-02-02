//
//  MatchingListModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/02.
//

import Foundation


// MARK: - MatchingListResponse
struct MatchingListResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [MatchingResult]
}

// MARK: - Result
struct MatchingResult: Codable {
    let matchingId: Int
    let customerId: Int
    let name, profile, pickUpType, orderDate: String
    let orderDateGap: Int
}
