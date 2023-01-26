//
//  CustomNotification.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/26.
//

import RealmSwift
import Realm

class CustomNotification:Object{
    @Persisted(primaryKey: true) var _id: ObjectId

    @Persisted var title:String = ""
    @Persisted var body:String = ""
    @Persisted var link:String = ""

    override static func primaryKey() -> String? {
      return "Notification"
    }

    convenience init(title:String,body:String,link:String){
        self.init()
        self.title = title
        self.body = body
        self.link = link
    }

}
