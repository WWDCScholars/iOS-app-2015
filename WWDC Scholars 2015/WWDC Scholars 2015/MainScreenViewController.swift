//
//  MainScreenViewController.swift
//  WWDC Scholars 2015
//
//  Created by Matthijs Logemann on 21-05-15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//
//

import UIKit
import ParseUI

class MainScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PFLogInViewControllerDelegate,UIViewControllerTransitioningDelegate  {
    
    @IBOutlet var scholarsCollectionView: UICollectionView!
    
    
    //var cell : UICollectionViewCell?
    let transition = BubbleTransition()
    var index:Int?
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ScholarshipCell", forIndexPath: indexPath) as! UICollectionViewCell
        
        if let scholar = DataManager.sharedInstance.scholarAtLocation(indexPath.row) {
            
            let nameTextView = cell.viewWithTag(201) as! UILabel
            nameTextView.text = scholar.firstName
            
            let profileImageView = cell.viewWithTag(202) as! AsyncImageView
            AsyncImageLoader.sharedLoader().cancelLoadingURL(profileImageView.imageURL)
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
        //cell = collectionView.cellForItemAtIndexPath(indexPath)
        if indexPath.row % 3 == 0 {
            index = 0
        } else if indexPath.row % 3 == 1 {
            index = 1
        } else {
            index = 2
        }
        self.performSegueWithIdentifier("toDetail", sender: self)
    }
    /*
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ImageFooter", forIndexPath: indexPath) as! MainScreenFooter
            footerView.backgroundImage.image = UIImage(named: "WWDCFooter.png")
            return footerView
        default:
            assert(false, "Unexpected element kind")
        }
    }*/
    
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
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateCollectionView", name: "onScholarsLoadedNotification", object: nil)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    func updateCollectionView(){
        scholarsCollectionView.reloadData()
    }
    
    func setColor(row:Int)->UIColor{
        if row == 0 {
            return UIColor(red: 46/255, green: 195/255, blue: 179/255, alpha: 1.0)
        } else if row == 1{
            return UIColor(red: 252/255, green: 63/255, blue: 85/255, alpha: 1.0)
        } else {
            return UIColor(red: 237/255, green: 204/255, blue: 64/255, alpha: 1.0)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dest = segue.destinationViewController as? DetailViewController {
            dest.currentScholar = DataManager.sharedInstance.scholarAtLocation(scholarsCollectionView.indexPathsForSelectedItems()[0].row)
            dest.transitioningDelegate = self
            dest.modalPresentationStyle = .Custom
           
        }
    }
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = self.view.center
        transition.bubbleColor =  setColor(index!)
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = self.view.center
        transition.bubbleColor = setColor(index!)
        return transition
    }
    
    /* REQUIRED, do not connect to any Outlet.
    BUG DETECTED? Exit segue doesn't dismiss automatically, so we have to dismiss it manually.
    */
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - PFLogInViewControllerDelegate Methods
    @IBAction func showLogin(sender: AnyObject) {
        var loginViewController = PFLogInViewController()
        loginViewController.delegate = self
        loginViewController.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.LogInButton | PFLogInFields.DismissButton
        //var signupViewController = PFSignUpViewController()
        //signupViewController.delegate = self
        //loginViewController.signUpController = signupViewController
        self.presentViewController(loginViewController, animated: true, completion: nil)
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        if(DeviceType.IS_IPHONE_5 || DeviceType.IS_IPHONE_4_OR_LESS){
            return CGSizeMake(85,85);
        }
        if (DeviceType.IS_IPHONE_6P){
            return CGSizeMake(115,115)
        }
  
        return CGSizeMake(100,100)
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        self.scholarsCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        println(scrollView)
    }
}
