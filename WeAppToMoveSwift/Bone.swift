//
//  ViewController.swift
//  Feeding Custom Cells to Collection Views Using .xib Files
//
//  Created by Vandad Nahavandipoor on 7/1/14.
//  Copyright (c) 2014 Pixolity Ltd. All rights reserved.
//
//  These example codes are written for O'Reilly's iOS 8 Swift Programming Cookbook
//  If you use these solutions in your apps, you can give attribution to
//  Vandad Nahavandipoor for his work. Feel free to visit my blog
//  at http://vandadnp.wordpress.com for daily tips and tricks in Swift
//  and Objective-C and various other programming languages.
//  
//  You can purchase "iOS 8 Swift Programming Cookbook" from
//  the following URL:
//  http://shop.oreilly.com/product/0636920034254.do
//
//  If you have any questions, you can contact me directly
//  at vandad.np@gmail.com
//  Similarly, if you find an error in these sample codes, simply
//  report them to O'Reilly at the following URL:
//  http://www.oreilly.com/catalog/errata.csp?isbn=0636920034254

import UIKit

class Bone: UICollectionViewController {
    
    // event data
    var eventData = Dictionary<String, String>()
    
    let allImages = [
        UIImage(named: "1"),
        UIImage(named: "2"),
        UIImage(named: "3")
    ]
    
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    let applicationModel = ApplicationData.sharedModel()

    var index:Int = 0
    
    func randomImage() -> UIImage{
        return allImages[Int(arc4random_uniform(UInt32(allImages.count)))]!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func handlePinches(pinch: UIPinchGestureRecognizer){
        
        let defaultLayoutItemSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 120)
        
        let layout = collectionView!.collectionViewLayout
            as UICollectionViewFlowLayout
        
        layout.itemSize =
            CGSize(width: defaultLayoutItemSize.width * pinch.scale,
                height: defaultLayoutItemSize.height * pinch.scale)
        
        layout.invalidateLayout()
        
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout!) {
        super.init(collectionViewLayout: layout)
        
        let nib = UINib(nibName: "DashboardCollectionViewCell", bundle: nil)
        
        collectionView!.registerNib(nib, forCellWithReuseIdentifier: "cell")
        collectionView!.backgroundColor = UIColor(red: (182/255.0), green: (183/255.0), blue: (186/255.0), alpha: 1.0)
        
    }
    
    convenience required init(coder aDecoder: NSCoder) {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 1000, height: 120)
        flowLayout.scrollDirection = .Vertical
        
        flowLayout.sectionInset =
            UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
        self.init(collectionViewLayout: flowLayout)
    }
    
    override func numberOfSectionsInCollectionView(
        collectionView: UICollectionView) -> Int {
            return applicationModel.activityData.count
    }
    
    override func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            /* Each section has between 10 to 15 cells */
            return Int(1)
    }
    
    override func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            
        var activity:ActivityModel = applicationModel.activityData[indexPath.section]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
                "cell", forIndexPath: indexPath) as DashboardCollectionViewCell
            cell.backgroundColor = UIColor.whiteColor()
            cell.titleLabel.text = activity.title
            cell.titleLabel.frame = CGRect(x: 10, y: 10, width: screenSize.width, height: 30)
            cell.locationLabel.text = activity.location
            cell.locationLabel.frame = CGRect(x: 10, y: 60, width: 200, height: 30)
            cell.participantsLabel.text = activity.location
            cell.participantsLabel.frame = CGRect(x: screenSize.width-100, y: 60, width: 100, height: 30)
            cell.footerView.frame = CGRect(x: 0, y: 91, width: screenSize.width, height: 29)
            cell.authorLabel.text = activity.user_id
            
            return cell
    }
    
    override func collectionView(collectionView: (UICollectionView!),
        didSelectItemAtIndexPath indexPath: NSIndexPath){
        let selectedCell = collectionView.cellForItemAtIndexPath(indexPath)
            
        var activityModel:ActivityModel = applicationModel.activityData[indexPath.section]
            applicationModel.selectedActivity = activityModel

        // go to detail page
        eventData["menu"] = "activityDetail"
            NSNotificationCenter.defaultCenter().postNotificationName("MenuChangedHandler", object: nil, userInfo:  eventData)
        
    }
}
