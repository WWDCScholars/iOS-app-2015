//
//  DetailViewController.swift
//  WWDC Scholars 2015
//
//  Created by Nicola Giancecchi on 21/05/15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var currentScholar : Scholar?
    
    
    @IBOutlet private weak var imgScholar: AsyncImageView!
    
    @IBOutlet private weak var btnGithubRepo: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var shortBioLabel: UILabel!
    
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func toGithub(sender: UIButton) {
    }
    
    @IBAction func emailClicked(sender: UIButton) {
    }
    
    
    @IBAction func facebookClied(sender: UIButton) {
    }
    
    @IBOutlet weak var twitterClicked: UIButton!
    
    
    
    
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
        
        btnGithubRepo.layer.cornerRadius = 5
        btnGithubRepo.layer.masksToBounds = true
        btnGithubRepo.layer.borderColor = UIColor.blackColor().CGColor
        btnGithubRepo.layer.borderWidth = 1.0
        
        self.navigationItem.title = "Scholar detail"
        
        
        
        // Do any additional setup after loading the view.
    }
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didOpenGithubRepo(sender: AnyObject) {
        //TODO: check nil -- if scholar doesn't have a github repo for the project, remove the button
        self.openBrowserWithURL(currentScholar!.githubLinkToApp!)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        let imageView : AsyncImageView = cell.viewWithTag(100) as! AsyncImageView
        
        if (currentScholar?.appDemo != nil && indexPath.item == 0) {
            imageView.imageURL = NSURL(string: "https://s-media-cache-ak0.pinimg.com/736x/5d/ad/1f/5dad1f8ba4815a4c2df7a2c6acd62e5b.jpg") //temp!!
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
            //open in photo browser
        }
    }
    
    private func openBrowserWithURL(url : String){
        let browser : NGBrowserViewController = NGBrowserViewController(url: url)
        self.navigationController?.pushViewController(browser, animated: true)
    }
    
}
