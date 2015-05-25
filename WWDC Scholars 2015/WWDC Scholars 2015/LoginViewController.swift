//
//  LoginViewController.swift
//  WWDC Scholars 2015
//
//  Created by Gelei Chen on 15/5/24.
//  Copyright (c) 2015年 WWDC-Scholars. All rights reserved.
//

import UIKit
import ParseUI

class LoginViewController: UIViewController,PFLogInViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        if (PFUser.currentUser() == nil) {
            var loginViewController = PFLogInViewController()
            loginViewController.delegate = self
            loginViewController.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.LogInButton | PFLogInFields.DismissButton
            //var signupViewController = PFSignUpViewController()
            //signupViewController.delegate = self
            //loginViewController.signUpController = signupViewController
            self.presentViewController(loginViewController, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        if ((count(username) != 0) && (count(password) != 0)) {
            return true
        } else {
            var alert = UIAlertView(title: "Empty field", message: "Some of the fields are empty. Please fill them in to log in.", delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
            return false
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
    self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
    self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
    var ok = true
    for (key, object) in info {
    var string = object as? String
    if let newString = string {
    if count(newString) == 0 {
    ok = false
    }
    }
    }
    return ok
    }
    */

    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
