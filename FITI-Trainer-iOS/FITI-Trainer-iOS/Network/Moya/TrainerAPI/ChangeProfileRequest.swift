//
//  TrainerProfileRequest.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/29.
//

import Foundation

struct ChangeProfileRequest: Codable {
    var profileImage: String
    
    init(profileImage: String) {
        self.profileImage = profileImage
    }
}
