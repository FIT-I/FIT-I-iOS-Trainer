//
//  MyPageServices.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/29.
//

import Foundation
import Moya

enum MyPageServices {
    case myPage
    case notice
    case policy
}

extension MyPageServices: TargetType {
    var baseURL: URL {
        return URL(string: BaseURL.BURL)!
    }
    
    var path: String {
        switch self {
        case .myPage:
            return "/api/communal/mypage"
        case .notice:
            return "/api/communal/announcement"
        case .policy:
            return "/api/communal/terms"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .myPage:
            return .get
        case .notice:
            return .get
        case .policy:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .myPage:
            return .requestPlain
        case .notice:
            return .requestPlain
        case .policy:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type":"application/json"]
        }
    }
    
    
}
