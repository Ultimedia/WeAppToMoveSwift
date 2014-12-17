//
//  PraktischViewController.swift
//  WeAppToMoveSwift
//
//  Created by Maarten Bressinck on 16/12/14.
//  Copyright (c) 2014 Maarten Bressinck. All rights reserved.
//

import UIKit

class PraktischViewController: UIViewController {
    let applicationModel = ApplicationData.sharedModel()
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var goingControl: UISegmentedControl!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var sportLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var orgLabel: UILabel!
    
    @IBOutlet weak var parView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)

        
        // content
        descriptionLabel.text = applicationModel.selectedActivity?.description
        sportLabel.text = applicationModel.selectedActivity?.sport_title
        timeLabel.text = applicationModel.selectedActivity!.startTime + " " + applicationModel.selectedActivity!.stopTime
        orgLabel.text = applicationModel.selectedActivity?.user_id

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goingControlSwitch(sender: AnyObject) {
        
        
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
