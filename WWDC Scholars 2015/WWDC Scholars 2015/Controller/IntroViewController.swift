//
//  IntroViewController.swift
//  Geek Photo
//
//  Created by Gelei Chen on 15/5/16.
//  Copyright (c) 2015年 Geilei_Chen. All rights reserved.
//

import UIKit

class IntroViewController: UINavigationController {
    
    
    let defauls = NSUserDefaults.standardUserDefaults()
    func showIntro(){
        
        let page1 = EAIntroPage()
        page1.title = "WWDC Scholars 2015"
        page1.desc = "test"
        page1.titleFont = UIFont(name: "Georgia-BoldItalic", size: 20)
        page1.titleColor = UIColor.blackColor()
        page1.descColor = UIColor.blackColor()
        page1.descFont = UIFont(name: "Georgia-Italic", size: 15)
        page1.titleIconView = UIImageView(image: UIImage(named: "wwdc2015-top-logo"))
        page1.titleIconView.contentMode = .ScaleAspectFit
        
        let page2 = EAIntroPage()
        page2.title = "WWDC Scholars 2015"
        page2.desc = "test"
        page2.titleIconView = UIImageView(image: UIImage(named: "wwdc2015-top-logo"))
        page2.titleColor = UIColor.blackColor()
        page2.titleFont = UIFont(name: "Georgia-BoldItalic", size: 20)
        page2.descColor = UIColor.blackColor()
        page2.descFont = UIFont(name: "Georgia-Italic", size: 15)
        
        
        
        
        let intro = EAIntroView(frame: self.view.bounds, andPages: [page1,page2])
        intro.bgImage = UIImage(named: "bg")
        
        intro.pageControlY = CGFloat(250)
        
        let btn = UIButton()
        btn.frame = CGRectMake(0, 0, 230, 40)
        btn.setTitle("SKIP NOW", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        intro.skipButton = btn
        intro.skipButtonY = CGFloat(60)
        intro.skipButtonAlignment = EAViewAlignment.Center
        intro.pageControl.pageIndicatorTintColor = UIColor.grayColor()
        intro.pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        
        intro.showInView(self.view, animateDuration: 0.3)
        
        
        
        //defauls.setObject("YES", forKey: "intro_screen_viewed")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (defauls.objectForKey("intro_screen_viewed") == nil) {
            showIntro()
        }
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
