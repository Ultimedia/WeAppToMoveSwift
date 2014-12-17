//
//  ViewController.swift
//  WeAppToMoveSwift
//
//  Created by Maarten Bressinck on 10/12/14.
//  Copyright (c) 2014 Maarten Bressinck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // applicationModel
    let applicationModel = ApplicationData.sharedModel()
    
    // Screen size
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    // views
    var loginView:LoginViewController?
    var registerView:RegisterViewController?
    var dashboardView:DashboardViewController?
    var newActivityView:NewActivityViewController?
    var activityDetail:ActivityDetailViewController?

    var targetController:UIViewController?
    
    // Bools
    var connectionFound = false
    var firstRun:Bool = true

    // Services
    let dataServices = DataManager.dataManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // map views to storyboards
        loginView = self.storyboard?.instantiateViewControllerWithIdentifier("Login") as LoginViewController
        registerView = self.storyboard?.instantiateViewControllerWithIdentifier("Register") as RegisterViewController
        dashboardView = self.storyboard?.instantiateViewControllerWithIdentifier("Dashboard") as DashboardViewController
        newActivityView = self.storyboard?.instantiateViewControllerWithIdentifier("NewActivity") as NewActivityViewController
        activityDetail = self.storyboard?.instantiateViewControllerWithIdentifier("ActivityDetailViewController") as ActivityDetailViewController

    
        // Check connection in a timed function
        var dataTimer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: Selector("checkDataConnection"), userInfo: nil, repeats: true)
    
        // menu changed handler
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "menuChangedHandler:", name:"MenuChangedHandler", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    * Handle navigation
    */
    func menuChangedHandler(notification: NSNotification){
        var createViewController:Bool = false
        var initialSetup:Bool = false
        
        if let info = notification.userInfo {
            var myTarget: String = (info["menu"] as String)
            var isPopup:Bool = false
            
            switch myTarget
            {
            case "login":
                targetController = loginView
                navigationController?.navigationBar.hidden = true

            case "register":
                targetController = registerView
                navigationController?.navigationBar.hidden = true

            case "dashboard":
                targetController = dashboardView
                navigationController?.navigationBar.hidden = false
                
            case "newActivity":
                targetController = newActivityView
                navigationController?.navigationBar.hidden = false
        
            case "activityDetail":
                targetController = activityDetail
                navigationController?.navigationBar.hidden = false
                
            default:
                println("none")
            }
            
            for (index, viewController) in enumerate(navigationController!.viewControllers) {
                if(targetController == viewController as? UIViewController){
                    createViewController = true
                }
            }
            
            var tar = targetController?.view
            if(!createViewController){
                navigationController?.pushViewController(targetController!, animated: false)
            }else{
                navigationController?.popToViewController(targetController!, animated: false)
            }
            
            
        } else {
            
            println("no valid data")
        }
    }
    
    
    /**
    * Check network connection
    */
    func checkDataConnection(){
        
        // first check if we have a connection
        if Reachability.isConnectedToNetwork() {
            applicationModel.networkConnection = true
            
            if(!connectionFound){
                connectionFound = true
                
                // load data
                dataServices.loadData()
                
            }
            
            // show views once data has loaded
            if(dataServices.dataLoaded && firstRun){
                
                
    
                // toggle the first run
                firstRun = false
                
                if(applicationModel.firstLogin == true){
                    navigationController?.pushViewController(loginView!, animated: false)
                    
                    
                }else{
                    navigationController?.pushViewController(dashboardView!, animated: true)
                }
                
                targetController = navigationController?.visibleViewController
            }else{
                
            }
            
        } else {
            applicationModel.networkConnection = false
            println("Netwerkverbinding: \(applicationModel.networkConnection)")
        }
    }


}

