//
//  NavigationViewController.swift
//  WeAppToMoveSwift
//
//  Created by Maarten Bressinck on 10/12/14.
//  Copyright (c) 2014 Maarten Bressinck. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    // applicationModel
    let applicationModel = ApplicationData.sharedModel()

    // screen size
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var eventData = Dictionary<String, String>()

    var menuViewController:MenuViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Bind custom events to handle page flow from this controller
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "toggleMenu:", name:"HideNavigation", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "menuBackgroundToggle:", name:"BackgroundMenu", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showMenu:", name:"ShowMenuHandler", object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func toggleMenu(notification: NSNotification){
        
        if let info = notification.userInfo {
            println(notification.userInfo)
            
            var viewy = self.menuViewController?.view
            
            UIView.animateWithDuration(0.4, delay: 0, options: nil, animations: {
                viewy!.alpha = 100
                viewy?.frame = CGRect(x:0, y:-viewy!.frame.height, width:self.screenSize.width, height:212)
                }, completion: { finished in
                    self.menuViewController?.removeFromParentViewController()
                    self.menuViewController?.view.removeFromSuperview()
                    
                    UIView.animateWithDuration(0.4, delay: 0, options: nil, animations: {
                        return
                        }, completion: { finished in
                            
                    })
            })
            
            
            var myTarget: String = (info["menu"] as String)
            eventData["menu"] = myTarget
            
            NSNotificationCenter.defaultCenter().postNotificationName("MenuChangedHandler", object: nil, userInfo:  eventData)
        }
    }
    
    
    func menuBackgroundToggle(notification: NSNotification){
        println("toggle menu background")
        
        if let toggle = notification.userInfo {
            var myTarget:Bool = (toggle["toggle"] as Bool)
            
            if(myTarget == true){
                
            }else{
                
            }
        }
    }
    

    
    
    /**
    * Handle navigation
    */
    func menuCloseHandler(notification: NSNotification){
        println("closing menu")
        
        var myView = view
        UIView.animateWithDuration(0.4, animations: {
            myView.alpha = 100
            
            },
            completion: { finished in if(finished) {
                
                }
        })
    }
    
    
    func showMenu(notification: NSNotification){
        
        
        menuViewController = MenuViewController(nibName: "MenuViewController", bundle: nil)
        self.addChildViewController(menuViewController!)
        self.view.addSubview(menuViewController!.view)
        var myView = menuViewController?.view
        myView?.frame = CGRect(x:(-screenSize.width), y:0, width:(self.screenSize.width/100)*80, height:screenSize.height)
        
        UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: {
            myView!.alpha = 100
            myView?.frame = CGRect(x:0, y:0, width:(self.screenSize.width/100)*80, height:212)
            }, completion: { finished in
                println("Basket doors opened!")
        })
        
        
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
