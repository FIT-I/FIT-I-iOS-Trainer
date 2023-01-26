//
//  Token.swift
//  FITI-Trainer-iOS
//
//  Created by 박윤빈 on 2023/01/26.
//

import RealmSwift
import Realm

class Token:Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var token:String = ""
    
    override static func primaryKey() -> String? {
      return "token"
    }
    
    convenience init(token:String){
        self.init()
        self.token = token
    }
}
