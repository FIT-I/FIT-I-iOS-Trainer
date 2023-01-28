//
//  SignInMode.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/26.
//

struct SignInModel: Codable {
    let name:String
    let email:String
    let password:String
    let major:String
}

// MARK: - SignInResponse
struct SignInResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: SignInResult
}

// MARK: - Result
struct SignInResult: Codable {
    let accessToken, refreshToken: String
}
