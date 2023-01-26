//
//  SignInRequest.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/26.
//

struct SignInRequest: Codable {
    var email: String
    var password: String
    
    init(_ email: String, _ password: String) {
        self.email = email
        self.password = password
    }
}
