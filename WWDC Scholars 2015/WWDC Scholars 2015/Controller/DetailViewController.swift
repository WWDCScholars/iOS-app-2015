//
//  DetailViewController.swift
//  WWDC Scholars 2015
//
//  Created by Nicola Giancecchi on 21/05/15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var imgScholar: UIImageView!
    
    @IBOutlet private weak var btnGithubRepo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgScholar.layer.cornerRadius = 30
        imgScholar.layer.masksToBounds = true
        
        btnGithubRepo.layer.cornerRadius = 5
        btnGithubRepo.layer.masksToBounds = true
        btnGithubRepo.layer.borderColor = UIColor.blackColor().CGColor
        btnGithubRepo.layer.borderWidth = 1.0
        
        self.navigationItem.title = "Scholar detail"
        
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
