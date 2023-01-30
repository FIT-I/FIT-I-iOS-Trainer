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
    let name, profile: String
    var background: String? = nil
    let levelName: String
    let school: String
    let grade: Double
    let cost: Int
    var intro: String? = nil
    var service: String? = nil
    let reviewDto, imageList: [String]
    let matching_state: Bool
}

//MARK: - UserInfo Struct
struct UserInfo {
    var userName = ""
    var profile = ""
    var email = ""
    var level = ""
    var cost : Int = 0
    var location = ""
    var intro = ""
    var service = ""
    var school = ""
    var grade : Double = 0
}

