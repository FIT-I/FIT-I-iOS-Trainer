//
//  AddEctImageModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/28.
//

import Foundation

struct AddEctImageResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: String
}
