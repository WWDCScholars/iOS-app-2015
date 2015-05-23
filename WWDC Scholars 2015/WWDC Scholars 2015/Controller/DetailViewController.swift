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
            return screenshots.count
        }else{
            return 0
        }
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.height/2, collectionView.frame.height)
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
