//
//  RegisterViewController.swift
//  WeAppToMoveSwift
//
//  Created by Maarten Bressinck on 10/12/14.
//  Copyright (c) 2014 Maarten Bressinck. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    // Screen size
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    var eventData = Dictionary<String, String>()

    var registerViewComponent:RegisterFormComponentViewController?

    

    var scrollView: UIScrollView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // add registerControls
        registerViewComponent = RegisterFormComponentViewController(nibName: "RegisterFormComponentViewController", bundle: nil)
        
        registerViewComponent!.view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        registerViewComponent!.view.backgroundColor = UIColor.whiteColor()
        
        self.addChildViewController(registerViewComponent!)
        
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 80, width: screenSize.width, height: screenSize.height-80))
        if let theScrollView = scrollView{
            //theScrollView.addSubview(imageView!)
            theScrollView.addSubview(registerViewComponent!.view)

            theScrollView.contentSize = CGSize(width: screenSize.width, height: screenSize.height+200)
            theScrollView.backgroundColor = UIColor.whiteColor()
            view.addSubview(theScrollView)
        }


        
        var center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
            var info:NSDictionary = notification.userInfo!
            var keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as NSValue).CGRectValue()
            
            var keyboardHeight:CGFloat = keyboardSize.height
            
            var animationDuration:CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as CGFloat
            var origin:CGFloat = self.view.frame.origin.y
            
            UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.view.frame = CGRectMake(0, (origin - keyboardHeight), self.view.bounds.width, self.view.bounds.height)
                }, completion: nil)
            
    }
    
    // back to the previous screen
    @IBAction func backButtonClickHandler(sender: AnyObject) {

        eventData["menu"] = "login"
        NSNotificationCenter.defaultCenter().postNotificationName("MenuChangedHandler", object: nil, userInfo:  eventData)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        var info:NSDictionary = notification.userInfo!
        var keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as NSValue).CGRectValue()
                    
        var keyboardHeight:CGFloat = keyboardSize.height
                    
        var animationDuration:CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as CGFloat
        var origin:CGFloat = self.view.frame.origin.y
                    
        UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.view.frame = CGRectMake(0, (origin + keyboardHeight), self.view.bounds.width, self.view.bounds.height)
        }, completion: nil)
                    
    }
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
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
