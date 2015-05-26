//
//  MainScreenViewController.swift
//  WWDC Scholars 2015
//
//  Created by Matthijs Logemann on 21-05-15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ScholarshipCell", forIndexPath: indexPath) as! UICollectionViewCell
        cell.backgroundColor = UIColor.orangeColor()
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
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
        cell.alpha = 0
        UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
            }, completion: nil)
        
        UIView.animateWithDuration(0.45, delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            cell.alpha = 1
            }, completion: nil)
    }
}
