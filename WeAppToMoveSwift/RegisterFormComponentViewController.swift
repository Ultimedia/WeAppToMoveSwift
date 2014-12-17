//
//  RegisterFormComponentViewController.swift
//  WeAppToMoveSwift
//
//  Created by Maarten Bressinck on 10/12/14.
//  Copyright (c) 2014 Maarten Bressinck. All rights reserved.
//

import UIKit


class RegisterFormComponentViewController: UIViewController, UITextFieldDelegate  {

    // register
    @IBOutlet weak var ageSelector: UISegmentedControl!
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    @IBOutlet weak var genderSelector: UISegmentedControl!
    
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    
    
    // Screen size
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    

    var formValidator: FormValidator?
    var usernameValidator : FieldValidator?
    var emailValidator : FieldValidator?

    // Validation Rules are evaluated from left to right. The first rule is ValidationRuleType.Required the second is ValidationRuleType.FullName.

    
    // Eventdata
    var eventData = Dictionary<String, String>()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height + 150)
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.emailField.attributedPlaceholder = NSAttributedString(string:"Jouw email",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        
        self.usernameField.attributedPlaceholder = NSAttributedString(string:"Jouw gebruikersnaam",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        
        self.passwordField.attributedPlaceholder = NSAttributedString(string:"Jouw paswoord",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
        
        self.confirmPasswordField.attributedPlaceholder = NSAttributedString(string:"Bevestig jouw gebruikersnaam",
            attributes:[NSForegroundColorAttributeName: UIColor.grayColor()])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func slidervalueChanged(sender: AnyObject) {
        let f = ageSlider.value
        let s = NSString(format: "%.2f", f)
        
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        // Configure the number formatter to your liking
        let s2 = nf.stringFromNumber(f)
        
        emailErrorLabel.text = s2
    
    }
    
    @IBAction func signupButton(sender: AnyObject) {
        
        
        // lets validate
        var emailText:String = emailField.text
        var usernameText:String = usernameField.text
        var passwordText:String = passwordField.text
        var confirmPasswordText:String = confirmPasswordField.text
        var gender:String
        var age:Int = Int(ageSlider.value)
        
        var errorString:String = "Vul de volgende velden correct in: "
        
        // gender
        switch genderSelector.selectedSegmentIndex
        {
            case 0:
                gender = "1"
            case 1:
                gender = "0"
            default:
            break;
        }
        
        var emailV:Bool = false
        var usernV:Bool = false
        var passV:Bool = false
        
        // count elements
        if(countElements(emailText) > 3 && emailText.isEmail()){
            emailField.layer.borderColor = UIColor.blackColor().CGColor
            emailV = true
        }else{
            emailField.layer.borderColor = UIColor.redColor().CGColor
            emailField.layer.borderWidth = 1
            errorString += "email adres, "
            emailV = false
        }
        
        
        if(countElements(usernameText) > 3){
            usernameField.layer.borderColor = UIColor.blackColor().CGColor
            usernV = true
        }else{
            usernameField.layer.borderColor = UIColor.redColor().CGColor
            usernameField.layer.borderWidth = 1
            errorString += "gebruikersnaam, "
            usernV = false

        }
        
        if(passwordText == confirmPasswordText){
            passwordField.layer.borderColor = UIColor.blackColor().CGColor
            confirmPasswordField.layer.borderColor = UIColor.blackColor().CGColor
            passV = true

        }else{
            passwordField.layer.borderColor = UIColor.redColor().CGColor
            confirmPasswordField.layer.borderColor = UIColor.redColor().CGColor
            passwordField.layer.borderWidth = 1
            confirmPasswordField.layer.borderWidth = 1
            passV = false
        }
        
        
        if(countElements(passwordText) > 3){
            passwordField.layer.borderColor = UIColor.blackColor().CGColor
            passV = true
        }else{
            passwordField.layer.borderColor = UIColor.redColor().CGColor
            passwordField.layer.borderWidth = 1
            errorString += "paswoord, "
            passV = false
        }
        

        if(passV && usernV && emailV){
            eventData["menu"] = "dashboard"
        NSNotificationCenter.defaultCenter().postNotificationName("MenuChangedHandler", object: nil, userInfo:  eventData)
        }else{
            let alertController = UIAlertController(title: "Ongeldige gegevens", message:
                errorString, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Sluit", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

}


extension String {
    func isEmail() -> Bool {
        let regex = NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: .CaseInsensitive, error: nil)
        return regex?.firstMatchInString(self, options: nil, range: NSMakeRange(0, countElements(self))) != nil
    }
}