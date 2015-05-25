//
//  DetailViewController.swift
//  WWDC Scholars 2015
//
//  Created by Nicola Giancecchi on 21/05/15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit
import QuickLook

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var currentScholar : Scholar?
    private var social : Dictionary<String,String> = Dictionary<String,String>()
    var selectedImageView : String?
    
    @IBOutlet private weak var imgScholar: AsyncImageView!
    
    @IBOutlet private weak var cntGithubRepo: NSLayoutConstraint!
    @IBOutlet private weak var btnGithubRepo: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var shortBioLabel: UILabel!
    @IBOutlet weak var viewSocial: UIView!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = currentScholar?.name
        descriptionLabel.text = currentScholar?.shortBio
        
        if currentScholar?.numberOfWWDCAttend == 1 {
            shortBioLabel.text = "\((currentScholar?.age?.description)!) from \((currentScholar?.location)!)\nFirst time at WWDC!"
        } else {
            shortBioLabel.text = "\((currentScholar?.age?.description)!) from \((currentScholar?.location)!)\nHas attended WWDC \((currentScholar?.numberOfWWDCAttend?.description)!) times"
        }
        
        //descriptionLabel.text = currentScholar?.description
        let zoomRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: (currentScholar!.latitude), longitude: (currentScholar!.longitude)), 100000, 100000)
        mapView.setRegion(zoomRegion, animated: true)
        
        imgScholar.layer.cornerRadius = 30
        imgScholar.layer.masksToBounds = true
        imgScholar.imageURL = NSURL(string: currentScholar!.picture!)
        
        if let shortBio = currentScholar?.shortBio{
            descriptionLabel.text = shortBio
        }
        
        if (currentScholar?.appDemo == nil){
            btnGithubRepo.setTitle("", forState: .Normal)
            cntGithubRepo.constant = 0
        } else {
            btnGithubRepo.layer.cornerRadius = 5
            btnGithubRepo.layer.masksToBounds = true
            btnGithubRepo.layer.borderColor = btnGithubRepo.titleLabel?.textColor.CGColor
            btnGithubRepo.layer.borderWidth = 1.0
        }
        
        self.navigationItem.title = "More about " + currentScholar!.name!
        
        
        if let user = PFUser.currentUser() {
            if (user.username == currentScholar?.user?.username) {
self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: Selector("edit"))
            }
        
        if(currentScholar?.email != nil){
            social["mail"] = currentScholar!.email!
        }
        
        if(currentScholar?.github != nil){
            social["gh"] = currentScholar!.github!
        }
        
        if(currentScholar?.facebook != nil){
            social["fb"] = currentScholar!.facebook!
        }
        

            social["tw"] = currentScholar!.twitter!
        }
        
        let totalWidth : CGFloat = CGFloat((social.count*30)+((social.count-1)*10))
        let viewWidth : CGFloat = CGFloat(viewSocial.frame.size.width)
        var startingX : CGFloat = (viewWidth-totalWidth) / 2
        
        for key : String in social.keys {
            let value : String = social[key]!
            let btn : UIButton = UIButton()
            btn.frame = CGRectMake(startingX, CGFloat(0), CGFloat(30), CGFloat(30))
            btn.setImage(UIImage(named: key + "_logo"), forState: .Normal)
                
            viewSocial.addSubview(btn)
           
        }
    
        
        
    }
    
    func open_fb() {
        UIApplication.sharedApplication().openURL(NSURL(string:currentScholar!.facebook!)!)
    }
    
    func open_tw() {
        MRSocial.openTwitterProfile(currentScholar!.twitter!.lastPathComponent)
    }
    
    func edit() {
        //show edit view
    }
    
    func saveEdits() {
        //close edit view
        //update scholar object
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didOpenGithubRepo(sender: AnyObject) {
        if let url = currentScholar!.githubLinkToApp {
            self.openBrowserWithURL(currentScholar!.githubLinkToApp!)
        }
        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        let imageView : AsyncImageView = cell.viewWithTag(100) as! AsyncImageView
        
        if (currentScholar?.appDemo != nil && indexPath.item == 0) {
            imageView.image = UIImage(named: "video_placeholder.png")
        } else if let screenshots : [String] = currentScholar?.appScreenshots{
            
            var idx : Int = indexPath.item
            if(currentScholar?.appDemo != nil){
                idx = idx - 1
            }
            
            let url : String = screenshots[idx]
            imageView.imageURL = NSURL(string: url)
            
        }
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.size.height, collectionView.frame.size.height)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (currentScholar?.appScreenshots != nil){
            var count : Int = currentScholar!.appScreenshots!.count
            if (currentScholar?.appDemo != nil) {
                count++
            }
            return count
        } else {
            return 0
        }
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        if (currentScholar?.appDemo != nil && indexPath.item == 0) {
            self.openBrowserWithURL(currentScholar!.appDemo!)
        } else {
            var idx : Int = indexPath.item
            if(currentScholar?.appDemo != nil){
                idx = idx - 1
            }
            
            //code for opening photogallery here!
            if let screenshots : [String] = currentScholar?.appScreenshots{
                let url : String = screenshots[idx]
                self.selectedImageView = url
            }
            
            
            self.performSegueWithIdentifier("toPopup", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPopup" {
            let vc = segue.destinationViewController as! PopupViewController
            vc.imageURL = selectedImageView
            
            let popupSegue = segue as! CCMPopupSegue
            
            
            if (self.view.bounds.size.height < 420) {
                
                popupSegue.destinationBounds = CGRectMake(0, 0, 300, 400)
                //6 plus
            } else if (self.view.bounds.size.height == 736) {
                popupSegue.destinationBounds = CGRectMake(0, 0, (UIScreen.mainScreen().bounds.size.height-200) * 0.6, UIScreen.mainScreen().bounds.size.height-150)
                // 6
            } else if (self.view.bounds.size.height == 667) {
                popupSegue.destinationBounds = CGRectMake(0, 0, (UIScreen.mainScreen().bounds.size.height-150) * 0.65, UIScreen.mainScreen().bounds.size.height-150)
                // 5s / 5
            } else if (self.view.bounds.size.height == 568) {
                popupSegue.destinationBounds = CGRectMake(0, 0, (UIScreen.mainScreen().bounds.size.height-150) * 0.7, UIScreen.mainScreen().bounds.size.height-150)
                // 4s
            } else if (self.view.bounds.size.height == 480) {
                popupSegue.destinationBounds = CGRectMake(0, 0, (UIScreen.mainScreen().bounds.size.height-100) * 0.76, UIScreen.mainScreen().bounds.size.height-150)
                // ipad
            } else {
                popupSegue.destinationBounds = CGRectMake(0, 0, (UIScreen.mainScreen().bounds.size.height-100) * 0.7, UIScreen.mainScreen().bounds.size.height-150)
            }
            popupSegue.backgroundBlurRadius = 7
            popupSegue.backgroundViewAlpha = 0.3
            popupSegue.backgroundViewColor = UIColor.blackColor()
            popupSegue.dismissableByTouchingBackground = true

        }
    }
    
    
    private func openBrowserWithURL(url : String){
        let browser : NGBrowserViewController = NGBrowserViewController(url: url)
        let nav : UINavigationController = UINavigationController(rootViewController: browser)
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
}
