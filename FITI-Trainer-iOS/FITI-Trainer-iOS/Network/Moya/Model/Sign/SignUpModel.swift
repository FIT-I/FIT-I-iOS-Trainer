//
//  SignInModel.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/26.
//

// MARK: - SignupModel
struct SignUpModel: Codable {
    let name:String
    let email:String
    let password:String
}

// MARK: - Welcome
struct SignUpResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message, result: String
}
