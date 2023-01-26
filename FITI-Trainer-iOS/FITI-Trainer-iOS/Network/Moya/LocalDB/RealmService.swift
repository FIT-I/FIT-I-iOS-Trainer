//
//  RealmService.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/26.
//

import RealmSwift
import Realm

class RealmService{
    
    let localRealm = try! Realm()
    
    func addToken(item:String){
        let token =  Token(token: item)
        try! localRealm.write{
            localRealm.add(token)
            
        }
    }
    
    func addProfile(Name:String,PW:String,Email:String,Location:String){
        let profile = Profile(Name: Name, PW: PW, Email: Email, Location: Location)
        try! localRealm.write{
            localRealm.add(profile)
        }
    }
    
    func addNotification(title:String,body:String,link:String){
        let CustomNotification = CustomNotification(title: title, body: body, link: link)
        try! localRealm.write{
            localRealm.add(CustomNotification)
        }
    }
    
    func getToken()->String{
        let token = localRealm.objects(Token.self)
        return token.last?.token ?? ""
    }
    
    func getProfileName()->String{
        let profile = localRealm.objects(Profile.self)
        return profile.last?.Name ?? ""
    }
    
    func getProfilePW()->String{
        let profile = localRealm.objects(Profile.self)
        return profile.last?.PW ?? ""
    }
    
    func getNotificationTitle()->String{
        let CustomNotification = localRealm.objects(CustomNotification.self)
        return CustomNotification.last?.title ?? ""
    }
    
    func getNotificationBody(index:Int)->String{
        let CustomNotification = localRealm.objects(CustomNotification.self)
        return CustomNotification.last?.body ?? ""
    }
    
    func getNotificationLink(index:Int)->String{
        let CustomNotification = localRealm.objects(CustomNotification.self)
        return CustomNotification.last?.link ?? ""
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
