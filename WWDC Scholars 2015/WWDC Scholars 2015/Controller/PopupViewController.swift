//
//  PopupViewController.swift
//  WWDC Scholars 2015
//
//  Created by Gelei Chen on 15/5/24.
//  Copyright (c) 2015年 WWDC-Scholars. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var imageView: AsyncImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var imageURL : String?{
        didSet{
                    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = UIImage(named: "no-profile")
        self.imageView.imageURL = NSURL(string: imageURL!)
        self.scrollView.contentSize = self.imageView.frame.size
        self.scrollView.minimumZoomScale = 0.03
        self.scrollView.maximumZoomScale = 1.5
        self.scrollView.delegate = self

        // Do any additional setup after loading the view.
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
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
