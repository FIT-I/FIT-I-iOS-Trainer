//
//  SignUpRequest.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/26.
//

struct SignUpRequest: Codable {
    var name: String
    var email: String
    var password: String
    var major: String
    
    init(_ name: String, _ email: String, _ password: String, _ major: String) {
        self.name = name
        self.email = email
        self.password = password
        self.major = major
    }
}
