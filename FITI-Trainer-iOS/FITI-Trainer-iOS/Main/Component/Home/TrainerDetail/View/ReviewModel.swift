//
//  ReviewModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/12.
//


import Foundation
import UIKit

struct ReviewModel {
    var image : UIImage!
    var name : String
    var date : String
    var content : String
}

let reviewDummy : [ReviewModel] = [
    ReviewModel(image: UIImage(named: "reviewerIcon.svg"), name: "홍준혁", date: "2022.12.2", content: "친절한 지도 감사합니다.친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)친절한 지도 감사합니다:)"),
    ReviewModel(image: UIImage(named: "reviewerIcon.svg"), name: "홍준혁", date: "2022.11.11", content: "친절한 지도 감사합니다."),
    ReviewModel(image: UIImage(named: "reviewerIcon.svg"), name: "홍준혁", date: "2022.10.23", content: "친절한 지도 감사합니다.")
]
