//
//  EditProfileServices.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/28.
//

import Foundation
import Moya

enum EditProfileServices {
    //param에 들어가는 것: request 할 값
    case changeInfo(param: ChangeInfoRequest)
//    case bottomPhoto(param: AddBottomImageRequest)
    case changeCategory(param: ChangeCategoryRequest)
//    case changeBackground(param: ChangeBackgroundRequest)
}

extension EditProfileServices: TargetType { //TargetType?: 네트워크에 필요한 속성들을 제공! (밑의 path, method 같은 것들)
    
    //baseURL 통해 endpoint 객체 생성
    public var baseURL: URL {
        return URL(string: BaseURL.BURL)!
    }
    
    //서버의 도메인 뒤에 추가 될 Path (일반적으로 API). case에 따른 endPoint를 생성
    var path: String {
        switch self {
        case .changeInfo:
            return "/api/trainer/information"
//        case .bottomPhoto:
//            return "/api/trainer/etcimg"
        case .changeCategory:
            return "/api/trainer/category"
//        case .changeBackground:
//            return "/api/trainer/bgimg"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .changeInfo:
            return .put
//        case .bottomPhoto:
//            return .post
        case .changeCategory:
            return . patch
//        case .changeBackground:
//            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .changeInfo(let param):
            return .requestJSONEncodable(param)
//        case .bottomPhoto(let param):
//            return .uploadMultipart(<#T##[MultipartFormData]#>)
        case .changeCategory(param: let param):
            return .requestJSONEncodable(param)
//        case .changeBackground(param: let param):
//            let imageData = UIImageJPEGRepresentation(param, 1.0)
//             let memberIdData = "\(user_id)".data(using: String.Encoding.utf8) ?? Data()
//             var formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData!), name: "cover_image", fileName: "asdas.png", mimeType: "image/jpeg")]
//             formData.append(Moya.MultipartFormData(provider: .data(memberIdData), name: "user_id"))
//             return .uploadMultipart(formData)
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
