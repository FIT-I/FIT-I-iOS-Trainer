//
//  EditProfileServices.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/28.
//

import Foundation
import UIKit
import Moya

//typealias profileImage = (profileImage: UIImage, description: String)
typealias parameter = (UIImage)
typealias parameters = ([UIImage])

enum EditProfileServices {
    //param에 들어가는 것: request 할 값
    case changeInfo(param: ChangeInfoRequest)
    case changeCategory(param: ChangeCategoryRequest)
    case uploadProfile(param: parameter)
    case uploadBackground(param: parameter)
    case uploadEctImage(param: [parameter])
    case deleteEctImage(_ etcImgIdx:Int)
    case deleteProfileImage
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
        case .changeCategory:
            return "/api/trainer/category"
        case .uploadProfile:
            return "/api/trainer/profile"
        case .uploadBackground:
            return "/api/trainer/bgimg"
        case .uploadEctImage:
            return "/api/trainer/etcimg"
        case .deleteEctImage(let etcImgIdx):
            return "/api/trainer/etcimg/\(etcImgIdx)"
        case .deleteProfileImage:
            return "/api/trainer/profile"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .changeInfo:
            return .put
        case .changeCategory:
            return . patch
        case .uploadProfile:
            return .patch
        case .uploadBackground:
            return .patch
        case .uploadEctImage:
            return .post
        case .deleteEctImage(_):
            return .delete
        case .deleteProfileImage:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .changeInfo(let param):
            return .requestJSONEncodable(param)
        case .changeCategory(param: let param):
            return .requestJSONEncodable(param)
        /*
        name: key값, fileName: 서버에 업로드할 파일 이름, mimeType: 파일 형식
        이미지 말고도, 다른 데이터를 보낼 필요가 있을 때 multipart type으로 post해줌. 데이터 별로 쪼개서(multipart) key - value형태로(formData) 만든 후, 그걸 하나로 합쳐서(append) 전송
        */
        case .uploadProfile(let param):
            let imageData = param.jpegData(compressionQuality: 1.0) ?? Data()
            let formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData), name: "profileImage", fileName: "userImage.jpeg", mimeType: "image/jpeg")]
            return .uploadMultipart(formData)
            
        case .uploadBackground(let param):
            let imageData = param.jpegData(compressionQuality: 1.0) ?? Data()
            let formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData), name: "backgroundImage", fileName: "userImage.jpeg", mimeType: "image/jpeg")]
            return .uploadMultipart(formData)
            
        case .uploadEctImage(param: let param):
            var formData: [Moya.MultipartFormData] = []
            for index in 0..<param.count{
                let imageData = param[index].jpegData(compressionQuality: 1.0) ?? Data()
                formData.append(Moya.MultipartFormData(provider: .data(imageData), name: "ectImage", fileName: "userImage.jpeg", mimeType: "image/jpeg"))
            }
            return .uploadMultipart(formData)
            
        case .deleteEctImage:
            return .requestPlain
        case .deleteProfileImage:
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
