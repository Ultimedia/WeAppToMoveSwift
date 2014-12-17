//
//  MuseumModel.swift
//  Rate
//
//  Created by Maarten Bressinck on 25/11/14.
//  Copyright (c) 2014 Maarten Bressinck. All rights reserved.
//

import Foundation

class UserModel: NSObject, Printable {
    let user_id:String
    let facebook_id:String
    let email:String
    let facebook_data:String
    let avatar:String
    let current_location:String
    let strength_score:String
    let stamina_score:String
    let equipment_score:String
    let gender:String
    let age:String

    
    init(user_id: String?, facebook_id: String?, email: String?, facebook_data: String?, avatar: String?, current_location: String?,strength_score: String?, stamina_score: String?, equipment_score: String?, gender: String?, age: String?) {
        self.user_id = user_id ?? ""
        self.facebook_id = facebook_id ?? ""
        self.email = email ?? ""
        self.facebook_data = facebook_data ?? ""
        self.avatar = avatar ?? ""
        self.current_location = current_location ?? ""
        self.strength_score = strength_score ?? ""
        self.stamina_score = stamina_score ?? ""
        self.equipment_score = equipment_score ?? ""
        self.gender = gender ?? ""
        self.age = age ?? ""
    }
}
