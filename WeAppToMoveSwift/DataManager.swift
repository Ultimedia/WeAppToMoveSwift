//
//  DataManager.swift
//  TopApps
//
//  Created by Dani Arnaout on 9/2/14.
//  Edited by Eric Cerney on 9/27/14.
//  Copyright (c) 2014 Ray Wenderlich All rights reserved.
//

import Foundation


class DataManager: NSObject {
    let activitUrl = "http://ultimedia.biz/watm/services/api/activities"
    let userUrl = "http://ultimedia.biz/watm/services/api/users"
    var userSaveUrl = "http://ultimedia.biz/mulab/user"

    
    // Data load checks
    var userLoaded:Bool = false
    var museumLoaded:Bool = false
    var dataLoaded:Bool = false
    
    // applicationModel
    let applicationModel = ApplicationData.sharedModel()

    
    func checkDataLoad(){
        if(userLoaded == true && museumLoaded == true){
            dataLoaded = true
        }
    }
    
    
    class func dataManager() -> DataManager {
        return _dataManager
    }
    

    /**
    * Load core applicationData
    */
    func loadData(){
        
        // Fetch userData from JSON
        getUserData { (userData) -> Void in
            let json = JSON(data: userData)
            
            // get all museums involved
            if let userArray = json["users"].arrayValue {
                var userData = [UserModel]()
                
                for user in userArray {

                    let user_id:String? = user["user_id"].stringValue
                    let facebook_id:String? = user["facebook_id"].stringValue
                    let email:String? = user["email"].stringValue
                    let facebook_data:String? = user["facebook_data"].stringValue
                    let avatar:String? = user["avatar"].stringValue
                    let current_location:String? = user["current_location"].stringValue
                    let strength_score:String? = user["strength_score"].stringValue
                    let stamina_score:String? = user["stamina_score"].stringValue
                    let equipment_score:String? = user["equipment_score"].stringValue
                    let gender:String? = user["gender"].stringValue
                    let age:String? = user["age"].stringValue
                    
                    var userModel = UserModel(user_id: user_id, facebook_id: facebook_id, email: email, facebook_data: facebook_data, avatar: avatar, current_location: current_location,strength_score: strength_score, stamina_score: stamina_score, equipment_score: equipment_score, gender: gender, age: age)
                    
                    self.applicationModel.userData.append(userModel)
                }
            }
            
            let mySelf = DataManager.dataManager()
                mySelf.userLoaded = true
                mySelf.checkDataLoad()
        }
        
        // Fetch museumData from JSON
        getActivityData { (activityData) -> Void in
            // show activity indicator, disable interactions
            
            let json = JSON(data: activityData)
            
            // get all museums involved
            if let activityArray = json["activities"].arrayValue {
                var activityData = [ActivityModel]()
                
                for activity in activityArray {

                    
                    let activity_id:String? = activity["activity_id"].stringValue
                    let user_id:String? = activity["user_id"].stringValue
                    let title:String? = activity["title"].stringValue
                    let sport_id:String? = activity["sport_id"].stringValue
                    let date:String? = activity["date"].stringValue
                    let time:String? = activity["time"].stringValue
                    let location_id:String? = activity["location_id"].stringValue
                    let activity_description:String? = activity["activity_description"].stringValue
                    let participants:String? = activity["participants"].stringValue
                    let stopTime:String? = activity["stopTime"].stringValue
                    let startTime:String? = activity["startTime"].stringValue
                    let sport_title:String? = activity["sport_title"].stringValue
                    var location:String? = activity["location"].stringValue
                    var coordinates:String? = activity["coordinates"].stringValue
                    
                    
                    var activityModel = ActivityModel(activity_id: activity_id, user_id: user_id, title: title, sport_id: sport_id, date: date, time: time, location_id: location_id, location:location,coordinates:coordinates, activity_description: activity_description, participants: participants, stopTime:stopTime, startTime:startTime, sport_title:sport_title)
                    
                    // now push everything to the main applicationModel
                    self.applicationModel.activityData.append(activityModel)
                }
            }
            
            let mySelf = DataManager.dataManager()
            mySelf.museumLoaded = true
            mySelf.checkDataLoad()
        }
    }

    

    /**
    * Post user data to server
    */
    func postUserData(userModel:UserModel){
        
        let user_id:String? = userModel.user_id
        let facebook_id:String? = userModel.facebook_id
        let email:String? = userModel.email
        let facebook_data:String? = userModel.facebook_data
        let avatar:String? = userModel.avatar
        let current_location:String? = userModel.current_location
        let strength_score:String? = userModel.strength_score
        let stamina_score:String? = userModel.stamina_score
        let equipment_score:String? = userModel.equipment_score
        let gender:String? = userModel.age
        let age:String? = userModel.age
        
        
        var urlAsString = ""
        urlAsString += "facebook_id=" + facebook_id!
        urlAsString += "&email=" + email!
        urlAsString += "&facebook_data=" + facebook_data!
        urlAsString += "&avatar=" + avatar!
        urlAsString += "&current_location=" + current_location!
        urlAsString += "&strength_score=" + strength_score!
        urlAsString += "&stamina_score=" + stamina_score!
        urlAsString += "&equipment_score=" + equipment_score!
        urlAsString += "&gender=" + gender!
        urlAsString += "&age=" + age!
        
        postData(userSaveUrl, dataString: urlAsString)
    }
    
    
    func postData(urlString:String, dataString:String){
        let httpMethod = "POST"
        let timeout = 15
        
        let body = dataString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let queue = NSOperationQueue()
        
        let url = NSURL(string: urlString)
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData,timeoutInterval: 15.0)
            urlRequest.HTTPMethod = httpMethod
            urlRequest.HTTPBody = body
        
        NSURLConnection.sendAsynchronousRequest(urlRequest,
            queue: queue, completionHandler: {(response: NSURLResponse!,
                data: NSData!,
                error: NSError!) in
                
                if data.length > 0 && error == nil{
                    let html = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("html = \(html)")
                } else if data.length == 0 && error == nil{
                    println("Nothing was downloaded")
                } else if error != nil{
                    println("Error happened = \(error)")
                }
            }
        )
    }

    
    /**
    * Get users
    */
    func getUserData(success: ((userData: NSData!) -> Void)) {
        
        loadDataFromURL(NSURL(string: userUrl)!, completion:{(data, error) -> Void in
        let applicationModel = ApplicationData.sharedModel()
        
        if let urlData = data {
            success(userData: urlData)
        }
        })
    }
    
    
    /**
    * Get musuem data
    */
    func getActivityData(success: ((activityData: NSData!) -> Void)) {
        loadDataFromURL(NSURL(string: activitUrl)!, completion:{(data, error) -> Void in
            
            println(error)
            
            
            let applicationModel = ApplicationData.sharedModel()

            if let urlData = data {
                success(activityData: urlData)
            }
        })
    }

    
    /**
    * Helper function to fetch data from an URL
    */
    func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        var session = NSURLSession.sharedSession()
    
        // Use NSURLSession to get data from an NSURL
        let loadDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            
            } else if let httpResponse = response as? NSHTTPURLResponse {
                
                if httpResponse.statusCode != 200 {
                    println(200)
                    
                    var statusError = NSError(domain:"be.devine.bressinck", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        })
        loadDataTask.resume()
    }
}
let _dataManager:DataManager = { DataManager() }()