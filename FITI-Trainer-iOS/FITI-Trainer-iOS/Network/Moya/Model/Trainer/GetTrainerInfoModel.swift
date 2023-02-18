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
    let result: Trainer
}

// MARK: - Result
struct Trainer: Codable {
    let name, profile: String
    var background: String? = nil
    let levelName: String
    let school: String
    let grade: Double
    let cost: String
    var intro: String? = nil
    var service: String? = nil
    var reviewDto: [ReviewDto]? = nil
    var imageList: [EctImageArray]? = nil
    let matching_state: Bool
    var category : String? = nil
    var openChatLink : String? = nil
}


struct ReviewDto: Codable {
    let name: String
    var profile: String? = nil
    let grade: Double
    let createdAt: String
    var contents: String? = nil
    let customerIdx: Int
}

struct EctImageArray: Codable {
    var etcImgIdx : Int
    var etcImgLink : String? = nil
}


//MARK: - UserInfo Struct
struct UserInfo {
    var userName = ""
    var profile = ""
    var backGround = ""
    var imageList : [String] = []
    var email = ""
    var level = ""
    var cost = ""
    var location = ""
    var intro = ""
    var service = ""
    var reviewDto: [ReviewDto]? = nil
    var school = ""
    var grade : Double = 0
    var matching_state = true
    var category = ""
    var imageListIdx : [Int] = []
    var openChatLink = ""
}

