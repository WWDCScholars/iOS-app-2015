//
//  DetailViewController.swift
//  WWDC Scholars 2015
//
//  Created by Nicola Giancecchi on 21/05/15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
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
        //        currentScholar = Scholar(name: "Gelei Chen", age: 19, birthdate: "", gender: "", latitude: 40.4240, longitude: -86.9290, email: "", picture: "", numberOfWWDCAttend: 1, appDemo: "", githubLinkToApp: "", twitter: "", facebook: "", github: "", linkedIn: "", website: "",location:"Purdue University, West Lafayette")
        
        nameLabel.text = currentScholar?.name
        if currentScholar?.numberOfWWDCAttend == 1 {
            shortBioLabel.text = (currentScholar?.age?.description)! + " from " + (currentScholar?.location)! + "\n" + "First time at WWDC!"
        } else {
            shortBioLabel.text = (currentScholar?.age?.description)! + " from " + (currentScholar?.location)! + "\n" + " Has attended WWDC " + (currentScholar?.numberOfWWDCAttend?.description)! + " times"
        }
        
        //descriptionLabel.text = currentScholar?.description
        let zoomRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: (currentScholar!.latitude), longitude: (currentScholar!.longitude)), 100000, 100000)
        mapView.setRegion(zoomRegion, animated: true)
        
        imgScholar.layer.cornerRadius = 30
        imgScholar.layer.masksToBounds = true
        imgScholar.imageURL = NSURL(string: currentScholar!.picture!)
        
        btnGithubRepo.layer.cornerRadius = 5
        btnGithubRepo.layer.masksToBounds = true
        btnGithubRepo.layer.borderColor = UIColor.blackColor().CGColor
        btnGithubRepo.layer.borderWidth = 1.0
        self.navigationItem.title = "Scholar Detail"
        if let user = PFUser.currentUser() {
            if (user.username == currentScholar?.user?.username) {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: Selector("edit"))
            }
        }
        // Do any additional setup after loading the view.
    }
    func edit() {
        //show edit view
    }
    
    func saveEdits() {
        //close edit view
        //update scholar object
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
