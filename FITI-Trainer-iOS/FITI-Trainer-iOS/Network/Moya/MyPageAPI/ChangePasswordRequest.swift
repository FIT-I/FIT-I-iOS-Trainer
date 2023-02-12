//
//  ChangePasswordRequest.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/13.
//

import Foundation

struct ChangePasswordRequest: Codable {
    var password: String? = nil
    var accessToken: String? = nil
    var refreshToken: String? = nil
    
    init(_ password: String, _ accessToken: String, _ refreshToken: String){
        self.password = password
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}
