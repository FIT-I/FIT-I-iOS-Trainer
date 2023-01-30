//
//  petchLocationModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/30.
//

import Foundation

struct patchLocationResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message, result: String
}
