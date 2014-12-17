//
//  LoginComponentViewController.swift
//  WeAppToMoveSwift
//
//  Created by Maarten Bressinck on 10/12/14.
//  Copyright (c) 2014 Maarten Bressinck. All rights reserved.
//

import UIKit

class LoginComponentViewController: UIViewController, FBLoginViewDelegate {

    var eventData = Dictionary<String, String>()
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var fbl: FBLoginView!
    
    // Screen size
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    // my user
    var userModel:UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.fbl.delegate = self
        self.fbl.readPermissions = ["public_profile", "email", "user_friends"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // facebookButton
    @IBAction func facebookButtonAnimation(sender: AnyObject) {
        // facebook login
        
        
    }
    
    // mailAction
    @IBAction func mailAction(sender: AnyObject) {
        eventData["menu"] = "register"
        NSNotificationCenter.defaultCenter().postNotificationName("MenuChangedHandler", object: nil, userInfo:  eventData)
    }
    
    /**
    * Facebook Login
    */
    func signUpAction(sender: AnyObject) {
        loginComplete()
    }
    
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
        
        // now go to the next screen
        
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser){
        loginComplete()
    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }
    
    
    /**
    * Login Complete
    */
    func loginComplete(){
        
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
