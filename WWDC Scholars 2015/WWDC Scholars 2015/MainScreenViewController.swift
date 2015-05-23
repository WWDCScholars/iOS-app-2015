//
//  MainScreenViewController.swift
//  WWDC Scholars 2015
//
//  Created by Matthijs Logemann on 21-05-15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit
import ParseUI

class MainScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    @IBOutlet var scholarsCollectionView: UICollectionView!
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ScholarshipCell", forIndexPath: indexPath) as! UICollectionViewCell
        
        if let scholar = DataManager.sharedInstance.scholarAtLocation(indexPath.row) {
            
            let nameTextView = cell.viewWithTag(201) as! UILabel
            nameTextView.text = scholar.name
            
            let profileImageView = cell.viewWithTag(202) as! AsyncImageView
            profileImageView.image = UIImage(named: "no-profile")
            profileImageView.imageURL = NSURL(string: scholar.picture!)
        }
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.sharedInstance.scholarArray.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ImageFooter", forIndexPath: indexPath) as! MainScreenFooter
            footerView.backgroundImage.image = UIImage(named: "WWDCFooter.png")
            return footerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
//        cell.alpha = 0
        UIView.animateWithDuration(0.30, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
            }, completion: nil)
        
//        UIView.animateWithDuration(0.40, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
//            cell.alpha = 1
//            }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateCollectionView", name: "onScholarsLoadedNotification", object: nil)
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (PFUser.currentUser() == nil) {
            var loginViewController = PFLogInViewController()
            loginViewController.delegate = self
            var signupViewController = PFSignUpViewController()
            signupViewController.delegate = self
            loginViewController.signUpController = signupViewController
            self.presentViewController(loginViewController, animated: true, completion: nil)
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        if ((count(username) != 0) && (count(password) != 0)) {
            return true
        } else {
            var alert = UIAlertView(title: "Empty field", message: "Some of the fields are empty. Please fill them in to log in.", delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
            return false
        }
    }
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        var ok = true
        for (key, object) in info {
            var string = object as? String
            if let newString = string {
                if count(newString) == 0 {
                    ok = false
                }
            }
        }
        return ok
    }
    
    func updateCollectionView(){
        scholarsCollectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dest = segue.destinationViewController as? DetailViewController {
            dest.currentScholar = DataManager.sharedInstance.scholarAtLocation(scholarsCollectionView.indexPathsForSelectedItems()[0].row)
        }
    }
}
