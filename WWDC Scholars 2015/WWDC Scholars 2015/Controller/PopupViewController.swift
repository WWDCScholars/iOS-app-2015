//
//  PopupViewController.swift
//  WWDC Scholars 2015
//
//  Created by Gelei Chen on 15/5/24.
//  Copyright (c) 2015年 WWDC-Scholars. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var imageView: AsyncImageView!
    
    var imageURL : String?{
        didSet{
                    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = UIImage(named: "no-profile")
        self.imageView.imageURL = NSURL(string: imageURL!)

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
