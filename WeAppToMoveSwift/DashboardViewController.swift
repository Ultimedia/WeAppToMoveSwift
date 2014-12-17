//
//  DashboardViewController.swift
//  WeAppToMoveSwift
//
//  Created by Maarten Bressinck on 10/12/14.
//  Copyright (c) 2014 Maarten Bressinck. All rights reserved.
//

import UIKit
import MapKit

class DashboardViewController: UIViewController {

    // Screen size
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    // components
    var dashboardActivityListComponent:Bone?
    
    var mapView: MKMapView?
    var filterMenuBackground:UIView?
    var header:HeaderComponentViewController?
    
    var distanceButton:UIButton?
    var dateButton:UIButton?
    var favoritesButton:UIButton?
    
    // applicationModel
    let applicationModel = ApplicationData.sharedModel()

    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // map
        mapView = MKMapView()
        mapView?.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height/2)
        mapView?.showsUserLocation = true
        view.addSubview(mapView!)
        
        
        // add markers
        for activity in applicationModel.activityData{
            //activity.location_id
            
            
            var coordinates:String = activity.coordinates
            let coordinatesArr = coordinates.componentsSeparatedByString(",")
            

            
            var wageConversion = (coordinatesArr[0] as NSString).doubleValue
            println(wageConversion)
            
            var wageConversion2 = (coordinatesArr[1] as NSString).doubleValue
            println(wageConversion2)
            
            
            
            var t:CLLocationDegrees = wageConversion as CLLocationDegrees
            var e:CLLocationDegrees = wageConversion2 as CLLocationDegrees

            
            //
            
            let location = CLLocationCoordinate2D(
                latitude: t,
                longitude: e
            )
            
            let annotation = MKPointAnnotation()
            annotation.setCoordinate(location)
            annotation.title = activity.title
            annotation.subtitle = activity.sport_title
            mapView!.addAnnotation(annotation)
        }
        
        
        // dasboard
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: screenSize.width-20, height: 120)
        
        
        view.backgroundColor = UIColor.redColor()
        dashboardActivityListComponent = Bone(collectionViewLayout: layout)
        dashboardActivityListComponent?.view.frame = CGRect(x: 0, y: (screenSize.height/2)+25, width: screenSize.width, height: (screenSize.height/2)-25)
        dashboardActivityListComponent?.view.backgroundColor = UIColor.greenColor()
        view.addSubview(dashboardActivityListComponent!.view)
        self.addChildViewController(dashboardActivityListComponent!)
        
        
        // filtermenu
        filterMenuBackground = UIView()
        filterMenuBackground?.frame = CGRect(x: 0, y: (screenSize.height/2)-25, width: screenSize.width, height: 50)
        filterMenuBackground?.backgroundColor = UIColor.blackColor()
        view.addSubview(filterMenuBackground!)
        
        
        // filter options
        let menuImage = UIImage(named: "hamburger-ico") as UIImage?
        distanceButton = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        distanceButton?.addTarget(self, action: "filterActivities:", forControlEvents: UIControlEvents.TouchUpInside)
        distanceButton?.setTitle("", forState: UIControlState.Normal)
        distanceButton?.titleLabel?.textAlignment = .Left
        distanceButton?.frame = CGRectMake(20, 10, 40, 30)
        distanceButton?.backgroundColor = UIColor.redColor()
        favoritesButton?.tag = 1
        filterMenuBackground!.addSubview(distanceButton!)
        
        dateButton = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        dateButton?.addTarget(self, action: "filterActivities:", forControlEvents: UIControlEvents.TouchUpInside)
        dateButton?.setTitle("", forState: UIControlState.Normal)
        dateButton?.titleLabel?.textAlignment = .Left
        dateButton?.frame = CGRectMake(100, 10, 40, 30)
        dateButton?.backgroundColor = UIColor.redColor()
        favoritesButton?.tag = 2
        filterMenuBackground!.addSubview(dateButton!)
        
        favoritesButton = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        favoritesButton?.addTarget(self, action: "filterActivities:", forControlEvents: UIControlEvents.TouchUpInside)
        favoritesButton?.setTitle("", forState: UIControlState.Normal)
        favoritesButton?.titleLabel?.textAlignment = .Left
        favoritesButton?.frame = CGRectMake(150, 10, 40, 30)
        favoritesButton?.backgroundColor = UIColor.redColor()
        favoritesButton?.tag = 3
        filterMenuBackground!.addSubview(favoritesButton!)
        
        
        // header
        header = HeaderComponentViewController(nibName: "HeaderComponentViewController", bundle: nil)
        header!.view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 67)
        
        
        view.addSubview(header!.view)
        header!.titleLabel.text = "Overzicht"

    }
    

    func filterActivities(sender:UIButton){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
