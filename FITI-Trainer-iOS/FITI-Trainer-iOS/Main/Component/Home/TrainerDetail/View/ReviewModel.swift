//
//  ReviewModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//


import Foundation
import UIKit


// MARK: - SpecificTrainerResponse
struct SpecificTrainerResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Trainer
}

// MARK: - Trainer
struct Trainer: Codable {
    var profile: String? = nil
    var background: String? = nil
    var name: String? = nil
    var levelName: String? = nil
    var school: String? = nil
    var grade: Double = 0
    var cost: String? = ""
    var intro: String? = nil
    var service: String? = nil
    var reviewDto: [ReviewDto]? = nil
    var imageList: [String]? = nil
    init(){}
}

// MARK: - ReviewDto
struct ReviewDto: Codable {
    let name: String
    var profile: String? = nil
    let grade: Double
    let createdAt: String
    var contents: String? = nil

}

//struct ReviewModel {
//
//}

//    var profile
//    var name : String
////    var date : String
////    var content : String
//    var grade : Double
//    let createdAt: String
//    var contents: String? = nil


//let reviewDummy : [ReviewModel] = [
//    ReviewModel(image: UIImage(named: "reviewerIcon.svg"), name: "홍준혁", date: "2022.12.2", content: "친절한 지도 감사합니다.친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)", grade: 4.24),
//    ReviewModel(image: UIImage(named: "reviewerIcon.svg"), name: "홍준혁", date: "2022.11.11", content: "친절한 지도 감사합니다.", grade: 4.2),
//    ReviewModel(image: UIImage(named: "reviewerIcon.svg"), name: "홍준혁", date: "2022.10.23", content: "친절한 지도 감사합니다.", grade: 4.2)
//]
