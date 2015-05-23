//
//  DetailViewController.swift
//  WWDC Scholars 2015
//
//  Created by Nicola Giancecchi on 21/05/15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var currentScholar : Scholar?
    
    var popUpView : UIView?
    
    var errorLabel: UILabel?
    
    @IBOutlet private weak var imgScholar: AsyncImageView!
    
    @IBOutlet private weak var btnGithubRepo: UIButton!
    
    @IBOutlet weak var shortBioLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func toGithub(sender: UIButton) {
        if (currentScholar?.githubLinkToApp != nil) {
            UIApplication.sharedApplication().openURL(NSURL(string:currentScholar!.githubLinkToApp!)!)
        }
        
        else {
            errorLabel?.text = currentScholar!.name! + " has not submitted their GitHub link. Email them and ask them to!"
            appearDisappear(popUpView!)
        }
    }
    
    @IBAction func emailClicked(sender: UIButton) {
    }
    
    
    @IBAction func facebookClicked(sender: AnyObject) {
        if (currentScholar?.facebook != nil) {
            UIApplication.sharedApplication().openURL(NSURL(string:currentScholar!.facebook!)!)
        }
        else {
            errorLabel?.text = currentScholar!.name! + " has not submitted their Facebook link. Email them and ask them to!"
            appearDisappear(popUpView!)
        }

    }
    
    
    @IBAction func twitterClicked(sender: AnyObject) {
        if (currentScholar?.twitter != nil) {
        UIApplication.sharedApplication().openURL(NSURL(string:currentScholar!.twitter!)!)
        }
        
        else {
            errorLabel?.text = currentScholar!.name! + " has not submitted their Twitter link. Email them and ask them to!"
            appearDisappear(popUpView!)
        }

    }
    
    func appearDisappear (view: UIView) {
        view.hidden = false
        view.alpha = 1.0
        UIView.animateWithDuration(0.2 as NSTimeInterval, delay: 2.0 as NSTimeInterval, options: UIViewAnimationOptions.AllowUserInteraction, animations: {view.alpha = 0.0}, completion: { (value: Bool) in view.hidden = true })
    }
    
    func configureErrorPopUp() {
        popUpView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 60, height: 50))
        popUpView?.frame.origin.x = (self.view.frame.size.width - popUpView!.frame.size.width ) / 2
        popUpView?.frame.origin.y = (self.view.frame.size.height  - popUpView!.frame.size.height) / 2
        
        popUpView?.backgroundColor = UIColor(red: (170.0/255.0), green: (170.0/255.0), blue: (170.0/255.0), alpha: 0.8)
        
        popUpView!.layer.cornerRadius = 5
        popUpView!.layer.masksToBounds = true
        
        self.errorLabel = UILabel(frame: CGRect(x : 0, y : 0, width : popUpView!.frame.size.width, height : popUpView!.frame.size.height))
        
        errorLabel?.numberOfLines = 2
        errorLabel?.textAlignment = NSTextAlignment.Center
        
        errorLabel!.font = UIFont(name: "Helvetica Neue", size: 12)
        errorLabel!.textColor = UIColor.blackColor()
        
        popUpView?.addSubview(errorLabel!)
        
        self.view.addSubview(popUpView!)
        popUpView?.hidden = true
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureErrorPopUp()
        
        let attributes = [NSFontAttributeName : UIFont(name: "HelveticaNeue-Medium", size: 19)!, NSForegroundColorAttributeName : UIColor(red: 0.30980392156862746, green: 0.69411764705882351, blue: 0.90196078431372551, alpha: 1)]
        
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        self.navigationItem.title = currentScholar?.name
        
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
        
        btnGithubRepo.layer.cornerRadius = 5
        btnGithubRepo.layer.masksToBounds = true
        btnGithubRepo.layer.borderColor = UIColor.blackColor().CGColor
        btnGithubRepo.layer.borderWidth = 1.0
        
        //self.navigationItem.title = "Scholar detail"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        if let screenshots = currentScholar?.appScreenshots{
            
//            let nameTextView = cell.viewWithTag(201) as! UILabel
//            nameTextView.text = scholar.name
//            
//            let profileImageView = cell.viewWithTag(202) as! AsyncImageView
//            profileImageView.image = UIImage(named: "no-profile")
//            profileImageView.imageURL = NSURL(string: scholar.picture!)
        }
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let screenshots = currentScholar?.appScreenshots{
            return 4
        }else{
            return 0
        }
    }

    
    //    override func viewDidAppear(animated: Bool) {
    //        super.viewDidAppear(animated)
    //
    //        nameLabel.text = currentScholar?.name
    //        if currentScholar?.numberOfWWDCAttend == 1 {
    //            shortBioLabel.text = (currentScholar?.age?.description)! + " from " + (currentScholar?.location)! + "\n" + "First time at WWDC!"
    //        } else {
    //            shortBioLabel.text = (currentScholar?.age?.description)! + " from " + (currentScholar?.location)! + "\n" + " Has attended WWDC " + (currentScholar?.numberOfWWDCAttend?.description)! + " times"
    //        }
    //
    //        //descriptionLabel.text = currentScholar?.description
    //        let zoomRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: (currentScholar!.latitude), longitude: (currentScholar!.longitude)), 100000, 100000)
    //        mapView.setRegion(zoomRegion, animated: true)
    //    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
