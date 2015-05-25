//
//  MainScreenViewController.swift
//  WWDC Scholars 2015
//
//  Created by Matthijs Logemann on 21-05-15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var scholarsCollectionView: UICollectionView!
    
    
    /*Create your transition manager instance*/
    var transition = QZCircleSegue()
    var index:Int?
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
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateCollectionView", name: "onScholarsLoadedNotification", object: nil)
        
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
            /* Send the button to your transition manager */
            self.transition.animationChild = self.view
            /* Set the color to your transition manager*/
            self.transition.animationColor = setColor(index!)
            /* Set both, the origin and destination to your transition manager*/
            self.transition.fromViewController = self
            self.transition.toViewController = dest
            /* Add the transition manager to your transitioningDelegate View Controller*/
            dest.transitioningDelegate = transition
        }
    }
    
    /* REQUIRED, do not connect to any Outlet.
    BUG DETECTED? Exit segue doesn't dismiss automatically, so we have to dismiss it manually.
    */
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
