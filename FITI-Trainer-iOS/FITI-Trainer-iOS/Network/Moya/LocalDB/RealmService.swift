//
//  RealmService.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/26.
//

import RealmSwift
import Realm

class RealmService{
    
    lazy var localRealm: Realm? = {
        do {
            return try Realm()
        } catch {
            print("Could not access Realm, \(error)")
            return nil
        }
    }()
    
    func addToken(accessToken:String,refreshToken:String){
        let token = Token(token: accessToken,refreshToken: refreshToken)
        try! localRealm?.write{
            localRealm?.add(token)
        }
    }

    func getToken()->String{
        let token = localRealm?.objects(Token.self)
        return token?.last?.token ?? ""
    }
    
    func getRefreshToken()->String{
        let token = localRealm?.objects(Token.self)
        return token?.last?.refreshToken ?? ""
    }

    // 스키마 수정시 한번 돌려야 한다.
    func resetDB(){
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
          realmURL,
          realmURL.appendingPathExtension("lock"),
          realmURL.appendingPathExtension("note"),
          realmURL.appendingPathExtension("management")
        ]

        for URL in realmURLs {
          do {
            try FileManager.default.removeItem(at: URL)
          } catch {
            // handle error
          }
        }
    }
    
    init() {
//        print("Realm Location: ", localRealm.configuration.fileURL ?? "cannot find location.")
    }

}

