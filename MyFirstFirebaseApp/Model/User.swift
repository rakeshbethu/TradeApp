//
//  User.swift
//  MyFirstFirebaseApp
//
//  Created by Rakesh Bethu on 4/20/18.
//  Copyright © 2018 Rakesh Bethu. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol DocumentSerializable{
    init?(dictionary:[String:Any])
}

struct UserModel{
    var UID:String
    var email:String
    var first:String
    var last:String
    var name:String
    var phone:String
    var username:String
   // var timeStamp:Date
    
    
    var dictionary:[String:Any]{
        return[
         "UID":UID,
         "email":email,
         "first":first,
         "last":last,
         "name":name,
         "phone":phone,
         "username":username
        ]
    }
}


extension UserModel: DocumentSerializable{
    init?(dictionary:[String:Any]) {
        guard let UID = dictionary["UID"] as? String,
        let email = dictionary["email"] as?  String,
        let first = dictionary["first"] as?  String,
        let last = dictionary["last"] as?  String,
        let name = dictionary["name"] as?  String,
        let phone = dictionary["phone"] as?  String,
            let username = dictionary["username"] as?  String   else{return nil}
        
        self.init(UID: UID, email: email, first: first, last: last, name: name, phone: phone, username: username)
    }
}
