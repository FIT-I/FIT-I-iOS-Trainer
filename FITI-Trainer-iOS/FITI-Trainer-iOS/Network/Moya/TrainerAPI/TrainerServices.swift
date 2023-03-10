//
//  TrainerServices.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/30.
//

import Foundation
import Moya

enum TrainerServices {
    //param에 들어가는 것: request 할 값
    case loadTrainer
    case report(param: ReportRequest)
}

extension TrainerServices: TargetType { //TargetType?: 네트워크에 필요한 속성들을 제공! (밑의 path, method 같은 것들)
    
    //baseURL 통해 endpoint 객체 생성
    public var baseURL: URL {
        return URL(string: BaseURL.BURL)!
    }
    
    //서버의 도메인 뒤에 추가 될 Path (일반적으로 API). case에 따른 endPoint를 생성
    var path: String {
        switch self {
        case .loadTrainer:
            return "/api/trainer/information"
        case .report:
            return "/api/redbell/customer"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loadTrainer:
            return .get
        case .report:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .loadTrainer:
            return .requestPlain
        case .report(let param):
            return . requestJSONEncodable(param)
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
