//
//  MenuViewController.swift
//  WeAppToMoveSwift
//
//  Created by Maarten Bressinck on 11/12/14.
//  Copyright (c) 2014 Maarten Bressinck. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var activityButton: UIButton!
    @IBOutlet weak var planButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var newActivityButton: UIButton!
    @IBOutlet weak var profileNameLabel: UILabel!
    
    // event data
    var eventData = Dictionary<String, String>()
    
    // screensize
    let screenSize: CGRect = UIScreen.mainScreen().bounds

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.frame  = CGRect(x: 0, y: 0, width: (screenSize.width/80)*100, height: screenSize.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newAcitvityButtonAction(sender: AnyObject) {
        eventData["menu"] = "newactivity"
        NSNotificationCenter.defaultCenter().postNotificationName("MenuChangedHandler", object: nil, userInfo:  eventData)
    }

    @IBAction func profileButtonAction(sender: AnyObject) {
        eventData["menu"] = "profile"
        NSNotificationCenter.defaultCenter().postNotificationName("MenuChangedHandler", object: nil, userInfo:  eventData)
    }
    
    @IBAction func planningButtonAction(sender: AnyObject) {
        eventData["menu"] = "planning"
        NSNotificationCenter.defaultCenter().postNotificationName("MenuChangedHandler", object: nil, userInfo:  eventData)
    }
    
    @IBAction func activityButtonAction(sender: AnyObject) {
        eventData["menu"] = "dashboard"
        NSNotificationCenter.defaultCenter().postNotificationName("MenuChangedHandler", object: nil, userInfo:  eventData)
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
