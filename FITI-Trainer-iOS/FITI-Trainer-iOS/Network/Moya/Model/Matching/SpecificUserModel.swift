//
//  SpecificUserModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/03.
//

import Foundation

struct SpecificUserResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    var result: userResult
}

// MARK: - Result
struct userResult: Codable {
    var matchingId: Int? =  nil
    var customerId: Int? = nil
    var name: String? = nil
    var pricePerHour: String? = nil
    var totalPrice: String? = nil
    var matchingStart: String? = nil
    var matchingFinish: String? = nil
    var matchingPeriod: Int? = nil
    var pickUpType:String? = nil
    var location: String? = nil
}

//MARK: - struct

struct MatchingUser {
    var name = ""
    var matchingId : Int? = 1222
    var customerId : Int? = 1220
    var pricePerHour = ""
    var totalPrice = ""
    var matchingStart = ""
    var matchingFinish = ""
    var matchingPeriod : Int? = nil
    var profile = ""
    var pickUpType = ""
    var location = ""
}
