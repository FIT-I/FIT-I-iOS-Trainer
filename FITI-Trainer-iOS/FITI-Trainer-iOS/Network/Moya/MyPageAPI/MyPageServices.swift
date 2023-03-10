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
    case policy
    case showProfile
    case locationSetting(_ location:String)
    case addOpenChat(_ openChatLink:String)
    case changPassword(param: ChangePasswordRequest)
    case withDraw
    case announcement
}

extension MyPageServices: TargetType {
    var baseURL: URL {
        return URL(string: BaseURL.BURL)!
    }
    
    var path: String {
        switch self {
        case .myPage:
            return "/api/communal/mypage"
        case .policy:
            return "/api/communal/terms"
        case .showProfile:
            return "/api/trainer/mymatching"
        case .locationSetting(let location):
            return "/api/communal/location/\(location)"

        case .addOpenChat(let openChatLink):
            return "/api/trainer/chat/\(openChatLink)"
        case .changPassword:
            return "/api/accounts/password"
        case .withDraw:
            return "/api/accounts/close"
        case .announcement:
            return "/api/communal/announcement"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .myPage:
            return .get
        case .policy:
            return .get
        case .showProfile:
            return .patch
        case .locationSetting(_):
            return .patch
        case .addOpenChat(_):
            return .patch
        case .changPassword:
            return .patch
        case .withDraw:
            return .patch
        case .announcement:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .myPage:
            return .requestPlain
        case .policy:
            return .requestPlain
        case .showProfile:
            return .requestPlain
        case .locationSetting:
            return .requestPlain
        case .addOpenChat(_):
            return .requestPlain
        case .changPassword(let param):
            return .requestJSONEncodable(param)
        case .withDraw:
            return .requestPlain
        case .announcement:
            return .requestPlain
        }
    }
    var headers: [String : String]? {
        switch self {
        default:
            let realm = RealmService()
            let token = realm.getToken()
            return ["Content-Type":"application/json",
                    "Authorization": "Bearer \(token)"]
        }
    }
    
    var authorizationType: Moya.AuthorizationType? {
        switch self {
        default:
            return .bearer
        }
    }
}
