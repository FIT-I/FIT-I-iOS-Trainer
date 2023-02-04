//
//  matchingService.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/02/02.
//

import Foundation
import Moya

enum MatchingService {
    case loadMatchingList
    case specificUser(_ matchingIdx: Int)
    case requestReject(_ matchingIdx: Int)
    case acceptRequest(_ matchingIdx: Int, _ openChatLink:String)
}

extension MatchingService: TargetType {
    var baseURL: URL {
        return URL(string: BaseURL.BURL)!
    }
    
    var path: String {
        switch self{
        case .loadMatchingList:
            return "/api/matching/trainer"
            
        case .specificUser(let matchingIdx):
            return "/api/matching/\(matchingIdx)"
            
        case .requestReject(let matchingIdx):
            return "/api/matching/\(matchingIdx)/reject"
            
        case .acceptRequest(let matchingIdx, _):
            return "/api/matching/\(matchingIdx)/accept"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .loadMatchingList:
            return .get
        case .specificUser:
            return .get
        case .requestReject:
            return .patch
        case .acceptRequest:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self{
        case .loadMatchingList:
            return .requestPlain
        case .specificUser:
            return .requestPlain
        case .requestReject(_):
            return .requestPlain
        case .acceptRequest(_ , let openChatLink):
            return .requestParameters(parameters: ["openChatLink":openChatLink], encoding: URLEncoding.queryString)
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
