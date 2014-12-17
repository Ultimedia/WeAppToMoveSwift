//
//  ActivityDetailViewController.swift
//  WeAppToMoveSwift
//
//  Created by Maarten Bressinck on 16/12/14.
//  Copyright (c) 2014 Maarten Bressinck. All rights reserved.
//

import UIKit
import MapKit

class ActivityDetailViewController: UIViewController {

    var header:HeaderComponentViewController?
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let applicationModel = ApplicationData.sharedModel()
    var mapView: MKMapView?
    var addressView:UIView?
    var contentView:UIView?
    
    var locationLabel:UILabel!
    var locationButton: UIButton!
    
    var praktischButton: UIButton!
    var mediaButton: UIButton!
    var messagesButton: UIButton!
    
    var selectedView:UIViewController?
    var praktischViewController:PraktischViewController?
    var mediaViewController:MediaViewController?
    var messagesViewController:MessagesViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // map
        mapView = MKMapView()
        mapView?.frame = CGRect(x: 0, y: 66, width: screenSize.width, height: screenSize.height/3)
        mapView?.showsUserLocation = true
        view.addSubview(mapView!)
        
        
        // add marker to map
        var coordinates:String = applicationModel.selectedActivity!.coordinates
        let coordinatesArr = coordinates.componentsSeparatedByString(",")
        var wageConversion = (coordinatesArr[0] as NSString).doubleValue
        var wageConversion2 = (coordinatesArr[1] as NSString).doubleValue
        var t:CLLocationDegrees = wageConversion as CLLocationDegrees
        var e:CLLocationDegrees = wageConversion2 as CLLocationDegrees
        
        let location = CLLocationCoordinate2D(
            latitude: t,
            longitude: e
        )
        
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = applicationModel.selectedActivity!.title
        annotation.subtitle = applicationModel.selectedActivity!.sport_title
        mapView!.addAnnotation(annotation)
        
        let span = MKCoordinateSpanMake(0.10, 0.10)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView!.setRegion(region, animated: true)
        
        
        // address view
        addressView = UIView()
        addressView?.frame = CGRect(x: 0, y: mapView!.frame.origin.y + mapView!.frame.height, width: screenSize.width, height: 40)
        addressView?.backgroundColor = UIColor.blackColor()
        view.addSubview(addressView!)
        
        
        // adddres view label and button
        locationLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 100, height: 40))
        locationLabel!.text = applicationModel.selectedActivity?.location
        locationLabel!.font = UIFont.boldSystemFontOfSize(14)
        locationLabel!.textColor = UIColor.whiteColor()
        addressView?.addSubview(locationLabel!)
        
        locationButton = UIButton.buttonWithType(.Custom) as? UIButton
        locationButton!.frame = CGRect(x: screenSize.width-100, y: 0, width: 100, height: 40)
        locationButton!.backgroundColor = UIColor.whiteColor()
        locationButton.titleLabel?.textColor = UIColor.redColor()
        locationButton!.setTitle("Toon de weg", forState: .Normal)
        locationButton.addTarget(self, action: "navigatePanel:", forControlEvents: UIControlEvents.TouchUpInside)

        addressView?.addSubview(locationButton!)


        // content view
        contentView = UIView()
        contentView?.frame = CGRect(x: 10, y: addressView!.frame.origin.y + addressView!.frame.height + 15, width: screenSize.width-20, height: screenSize.height)
        contentView!.backgroundColor = UIColor.whiteColor()
        view.addSubview(contentView!)
        
        // now add 3 tabs
        praktischButton = UIButton.buttonWithType(.Custom) as? UIButton
        praktischButton!.frame = CGRect(x: 0, y: 0, width: contentView!.frame.width/3, height: 40)
        praktischButton!.backgroundColor = UIColor.whiteColor()
        praktischButton.titleLabel?.textColor = UIColor.redColor()
        praktischButton!.setTitle("Praktisch", forState: .Normal)
        praktischButton!.addTarget(self, action: "contentSelection:", forControlEvents: UIControlEvents.TouchUpInside)
        praktischButton!.tag = 1
        
        mediaButton = UIButton.buttonWithType(.Custom) as? UIButton
        mediaButton!.frame = CGRect(x: contentView!.frame.width/3, y: 0, width: contentView!.frame.width/3, height: 40)
        mediaButton!.backgroundColor = UIColor.whiteColor()
        mediaButton.titleLabel?.textColor = UIColor.redColor()
        mediaButton!.setTitle("Media", forState: .Normal)
        mediaButton!.addTarget(self, action: "contentSelection:", forControlEvents: UIControlEvents.TouchUpInside)
        mediaButton!.tag = 2
        
        messagesButton = UIButton.buttonWithType(.Custom) as? UIButton
        messagesButton!.frame = CGRect(x: contentView!.frame.width*2, y: 0, width: contentView!.frame.width/3, height: 40)
        messagesButton!.backgroundColor = UIColor.whiteColor()
        messagesButton!.setTitle("Berichten", forState: .Normal)
        messagesButton!.addTarget(self, action: "contentSelection:", forControlEvents: UIControlEvents.TouchUpInside)
        messagesButton!.tag = 3
        
        contentView!.addSubview(praktischButton!)
        contentView!.addSubview(mediaButton!)
        contentView!.addSubview(messagesButton!)

        
        //praktischViewController (defualt view)
        praktischViewController = PraktischViewController(nibName: "PraktischViewController", bundle: nil)
        //mediaViewController = MediaViewController(nibName: "MediaViewController", bundle: nil)
        //messagesViewController = MessagesViewController(nibName: "MessagesViewController", bundle: nil)
        
        // add default
        contentView!.addSubview(praktischViewController!.view)
        //selectedView = praktischViewController
        
        // header
        header = HeaderComponentViewController(nibName: "HeaderComponentViewController", bundle: nil)
        header!.view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: 67)
        view.addSubview(header!.view)
        header!.titleLabel.text = applicationModel.selectedActivity?.title

        // backgroundview
        view.backgroundColor = UIColor.grayColor()
    }
    
    
    func contentSelection(sender:UIButton){
        
        /*
        contentView!.removeFromSuperview()
        
        switch(sender.tag){
            case 1:
                selectedView = praktischViewController

            break
            
            case 2:
                selectedView = mediaViewController

            break
            
            case 3:
                selectedView = messagesViewController

            break
            default:
                println("def")
        }
        
        contentView!.addSubview(selectedView!.view)*/
    }
    
    
    func navigatePanel(sender:UIButton){
        println("hello")
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
