//
//  CreditsViewController.swift
//  WWDC Scholars 2015
//
//  Created by Andrew Walker on 25/05/2015.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet weak var websiteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        websiteButton.layer.cornerRadius = 7
        websiteButton.layer.borderWidth = 0.5
        websiteButton.layer.borderColor = UIColor.orangeColor().CGColor
        
        // Do any additional setup after loading the view.
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
