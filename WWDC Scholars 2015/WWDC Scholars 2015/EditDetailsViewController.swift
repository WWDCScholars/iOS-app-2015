//
//  EditDetailsViewController.swift
//  WWDC Scholars 2015
//
//  Created by Sam Eckert on 27.05.15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit

class EditDetailsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var screenshotScrollview: UIScrollView!
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var age: UITextField!
    @IBOutlet var dateOfBirth: UITextField!
    @IBOutlet var gender: UITextField!
    @IBOutlet var cityCountry: UITextField!
    @IBOutlet var previousWWDC: UITextField!
    @IBOutlet var appVideo: UITextField!
    @IBOutlet var githubLink: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var twitterUsername: UITextField!
    @IBOutlet var facebookUsername: UITextField!
    @IBOutlet var githubUsername: UITextField!
    @IBOutlet var linkedinUsername: UITextField!
    @IBOutlet var websiteLink: UITextField!
    @IBOutlet var itunesLink: UITextField!
    
    
    @IBOutlet var shortBioCharactersLeft: UILabel!
    @IBOutlet var shortBio: UITextView!
    
    @IBOutlet var appScreenshot1: UIButton!
    @IBAction func appScreenshot1Button(sender: AnyObject) {
    }
    @IBOutlet var appScreenshot2: UIButton!
    @IBAction func appScreenshot2Button(sender: AnyObject) {
    }
    
    @IBOutlet var appScreenshot3: UIButton!
    @IBAction func appScreenshot3Button(sender: AnyObject) {
    }
    
    @IBOutlet var appScreenshot4: UIButton!
    @IBAction func appScreenshot4Button(sender: AnyObject) {
    }
    
    @IBOutlet var latitudeLongitude: UITextField!
    @IBAction func locationButton(sender: AnyObject) {
    }

    @IBOutlet var profpic: UIButton!
    @IBAction func profpicButton(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.scrollEnabled = true
        scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1500)
        scrollView.showsVerticalScrollIndicator = true
        
        screenshotScrollview.scrollEnabled = true
        screenshotScrollview.contentSize = CGSizeMake(600, 249)
        screenshotScrollview.showsHorizontalScrollIndicator = true

        
        let paddingView = UIView(frame: CGRectMake(0, 0, 8, self.firstName.frame.height))
        firstName.leftView = paddingView
        firstName.leftViewMode = UITextFieldViewMode.Always
        let paddingView2 = UIView(frame: CGRectMake(0, 0, 8, self.lastName.frame.height))
        lastName.leftView = paddingView2
        lastName.leftViewMode = UITextFieldViewMode.Always
        let paddingView3 = UIView(frame: CGRectMake(0, 0, 8, self.age.frame.height))
        age.leftView = paddingView3
        age.leftViewMode = UITextFieldViewMode.Always
        let paddingView4 = UIView(frame: CGRectMake(0, 0, 8, self.dateOfBirth.frame.height))
        dateOfBirth.leftView = paddingView4
        dateOfBirth.leftViewMode = UITextFieldViewMode.Always
        let paddingView5 = UIView(frame: CGRectMake(0, 0, 8, self.gender.frame.height))
        gender.leftView = paddingView5
        gender.leftViewMode = UITextFieldViewMode.Always
        let paddingView6 = UIView(frame: CGRectMake(0, 0, 8, self.cityCountry.frame.height))
        cityCountry.leftView = paddingView6
        cityCountry.leftViewMode = UITextFieldViewMode.Always
        let paddingView7 = UIView(frame: CGRectMake(0, 0, 8, self.previousWWDC.frame.height))
        previousWWDC.leftView = paddingView7
        previousWWDC.leftViewMode = UITextFieldViewMode.Always
        let paddingView8 = UIView(frame: CGRectMake(0, 0, 8, self.appVideo.frame.height))
        appVideo.leftView = paddingView8
        appVideo.leftViewMode = UITextFieldViewMode.Always
        let paddingView9 = UIView(frame: CGRectMake(0, 0, 8, self.githubLink.frame.height))
        githubLink.leftView = paddingView9
        githubLink.leftViewMode = UITextFieldViewMode.Always
        let paddingView10 = UIView(frame: CGRectMake(0, 0, 8, self.email.frame.height))
        email.leftView = paddingView10
        email.leftViewMode = UITextFieldViewMode.Always
        let paddingView11 = UIView(frame: CGRectMake(0, 0, 8, self.twitterUsername.frame.height))
        twitterUsername.leftView = paddingView11
        twitterUsername.leftViewMode = UITextFieldViewMode.Always
        let paddingView12 = UIView(frame: CGRectMake(0, 0, 8, self.facebookUsername.frame.height))
        facebookUsername.leftView = paddingView12
        facebookUsername.leftViewMode = UITextFieldViewMode.Always
        let paddingView13 = UIView(frame: CGRectMake(0, 0, 8, self.githubUsername.frame.height))
        githubUsername.leftView = paddingView13
        githubUsername.leftViewMode = UITextFieldViewMode.Always
        let paddingView14 = UIView(frame: CGRectMake(0, 0, 8, self.linkedinUsername.frame.height))
        linkedinUsername.leftView = paddingView14
        linkedinUsername.leftViewMode = UITextFieldViewMode.Always
        let paddingView15 = UIView(frame: CGRectMake(0, 0, 8, self.websiteLink.frame.height))
        websiteLink.leftView = paddingView15
        websiteLink.leftViewMode = UITextFieldViewMode.Always
        let paddingView16 = UIView(frame: CGRectMake(0, 0, 8, self.itunesLink.frame.height))
        itunesLink.leftView = paddingView16
        itunesLink.leftViewMode = UITextFieldViewMode.Always
        let paddingView17 = UIView(frame: CGRectMake(0, 0, 8, self.latitudeLongitude.frame.height))
        latitudeLongitude.leftView = paddingView17
        latitudeLongitude.leftViewMode = UITextFieldViewMode.Always

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
