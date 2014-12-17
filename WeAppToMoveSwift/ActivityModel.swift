//
//  MuseumModel.swift
//  Rate
//
//  Created by Maarten Bressinck on 25/11/14.
//  Copyright (c) 2014 Maarten Bressinck. All rights reserved.
//

import Foundation

class ActivityModel: NSObject, Printable {
    let activity_id:String
    let user_id:String
    let title:String
    let sport_id:String
    let date:String
    let time:String
    let location_id:String
    let location:String
    let activity_description:String
    let participants:String
    let stopTime:String
    let startTime:String
    let sport_title:String
    let coordinates:String
    
    init(activity_id: String?, user_id: String?, title: String?, sport_id: String?, date: String?, time: String?, location_id: String?, location:String?, coordinates:String?, activity_description: String?, participants: String?, stopTime:String?, startTime:String?, sport_title:String?) {

        self.activity_id = activity_id ?? ""
        self.user_id = user_id ?? ""
        self.title = title ?? ""
        self.sport_id = sport_id ?? ""
        self.date = date ?? ""
        self.time = time ?? ""
        self.location_id = location_id ?? ""
        self.location = location ?? ""
        self.activity_description = activity_description ?? ""
        self.participants = participants ?? ""
        self.stopTime = stopTime ?? ""
        self.startTime = startTime ?? ""
        self.coordinates = coordinates ?? ""
        self.sport_title = sport_title ?? ""
    }
}