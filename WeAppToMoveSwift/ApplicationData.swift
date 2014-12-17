//
//  ModelController.swift
//  PageBasedApplicationDemo
//
//  Created by Ravi Shankar on 13/08/14 edited by Maarten Bressinck
//  Copyright (c) 2014 Ravi Shankar. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import MapKit

class ApplicationData: NSObject {
    
    // Core Application Data
    var networkConnection:Bool = false
    var firstLogin:Bool = false
    
    // Defaults
    var defaultLocation = CLLocationCoordinate2D(
        latitude: 50.819478,
        longitude: 3.257726
    )
    
    // Models
    var userData:[UserModel] = []
    var activityData:[ActivityModel] = []
    var selectedActivity:ActivityModel?
    
    
    /**
    * Get local data
    */
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    func getStoredData(){
        
        
    }
    
    class func sharedModel() -> ApplicationData {
        return _sharedModel
    }
    
}
let _sharedModel : ApplicationData = { ApplicationData() }()