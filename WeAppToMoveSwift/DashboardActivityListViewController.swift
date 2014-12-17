//
//  DashboardActivityListViewController.swift
//  WeAppToMoveSwift
//
//  Created by Maarten Bressinck on 10/12/14.
//  Copyright (c) 2014 Maarten Bressinck. All rights reserved.
//

import UIKit

class DashboardActivityListViewController: UIViewController {

    // applicationModel
    let applicationModel = ApplicationData.sharedModel()
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 2222, height: 90)
    
        var collectionView:ActivityCollectionViewController = ActivityCollectionViewController(collectionViewLayout: layout)
            collectionView.view.backgroundColor = UIColor.redColor()
            collectionView.view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        view.addSubview(collectionView.view)
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
