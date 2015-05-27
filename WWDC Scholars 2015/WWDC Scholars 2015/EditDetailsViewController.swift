//
//  EditDetailsViewController.swift
//  WWDC Scholars 2015
//
//  Created by Sam Eckert on 27.05.15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit

class EditDetailsViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        scrollView.scrollEnabled = true
        scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1500)
        scrollView.showsVerticalScrollIndicator = true

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
