//
//  ChangeInfoRequest.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/28.
//
import Foundation

struct ChangeInfoRequest: Codable {
    var name: String
    var costHour: Int
    var intro: String
    var serviceDetail: String
    
    init(_ name: String, _ costHour: Int, _ intro: String, _ serviceDetail: String) {
        self.name = name
        self.costHour = costHour
        self.intro = intro
        self.serviceDetail = serviceDetail
    }
}
