//
//  CreditsViewController.swift
//  WWDC Scholars 2015
//
//  Created by Andrew Walker on 25/05/2015.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        websiteButton.layer.cornerRadius = 7
        websiteButton.layer.borderWidth = 0.5
        websiteButton.layer.borderColor = UIColor.purpleColor().CGColor
        
        loginButton.layer.cornerRadius = 7
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor = UIColor.purpleColor().CGColor
        
        backButton.layer.cornerRadius = 7
        backButton.layer.borderWidth = 0.5
        backButton.layer.borderColor = UIColor.purpleColor().CGColor
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pinched(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func swiped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        self.scrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width, 2030)
    }

    @IBAction func openWebsite(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://michieriffic.typeform.com/to/iLcHKn")!)
    }
    
    @IBAction func backButtonClicked(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
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
