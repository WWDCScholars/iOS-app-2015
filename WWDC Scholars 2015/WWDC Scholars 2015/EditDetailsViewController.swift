//
//  EditDetailsViewController.swift
//  WWDC Scholars 2015
//
//  Created by Sam Eckert on 27.05.15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit

class EditDetailsViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var screenshotScrollview: UIScrollView!
    var newImage = false
    
    //FIXED
    @IBOutlet var name: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    
    //CAN BE CHANGED
    
    
    
//    @IBOutlet var age: UITextField!
//    @IBOutlet var dateOfBirth: UITextField!
//    @IBOutlet var gender: UITextField!
    @IBOutlet var cityCountry: UITextField!
//    @IBOutlet var previousWWDC: UITextField!
    @IBOutlet var appVideo: UITextField!
    @IBOutlet var githubLink: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var twitterUsername: UITextField!
    @IBOutlet var facebookUsername: UITextField!
    @IBOutlet var githubUsername: UITextField!
    @IBOutlet var linkedinUsername: UITextField!
    @IBOutlet var websiteLink: UITextField!
    @IBOutlet var itunesLink: UITextField!
    
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var shortBioCharactersLeft: UILabel!
    @IBOutlet var shortBio: UITextView!
    
    var screenshot: NSInteger = 0

    
    
    
    
    @IBOutlet var appScreenshot1: UIButton!
    @IBAction func appScreenshot1Button(sender: AnyObject) {
        screenshot = 1
        picker.allowsEditing = false //2
        picker.sourceType = .PhotoLibrary //3
        presentViewController(picker, animated: true, completion: nil)
    }
    @IBOutlet var appScreenshot2: UIButton!
    @IBAction func appScreenshot2Button(sender: AnyObject) {
        screenshot = 2

        picker.allowsEditing = false //2
        picker.sourceType = .PhotoLibrary //3
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBOutlet var appScreenshot3: UIButton!
    @IBAction func appScreenshot3Button(sender: AnyObject) {
        screenshot = 3

        picker.allowsEditing = false //2
        picker.sourceType = .PhotoLibrary //3
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBOutlet var appScreenshot4: UIButton!
    @IBAction func appScreenshot4Button(sender: AnyObject) {
        screenshot = 4

        picker.allowsEditing = false //2
        picker.sourceType = .PhotoLibrary //3
        presentViewController(picker, animated: true, completion: nil)
    }
    

    @IBOutlet var profpic: UIButton!
    @IBAction func profpicButton(sender: AnyObject) {
        screenshot = 5
        
        picker.allowsEditing = false //2
        picker.sourceType = .PhotoLibrary //3
        presentViewController(picker, animated: true, completion: nil)
    }
    var user: PFObject!
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let length = count(textView.text) + count(text) - range.length
        if length <= 250 {
            shortBioCharactersLeft.text = "\(250-length)/250 characters left"
        }
        return (length <= 250)
    }
    
    

    @IBAction func save(sender: AnyObject) {
        if self.user != nil {
            self.verifyAndSubmit(self.user)
        } else {
            let query = PFQuery(className: "scholars")
            query.whereKey("user", equalTo: PFUser.currentUser()!)
            query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
                if let scholar = object {
                    self.verifyAndSubmit(scholar)
                                    }
            }
        }
    }
    
    
    let picker = UIImagePickerController()
    func squareImage(image: UIImage) -> UIImage? {
        var height: CGFloat = 0
        var width: CGFloat = 0
        var offsetX: CGFloat = 0
        var offsetY: CGFloat = 0
        if image.size.width > image.size.height {
            width = image.size.height
            height = image.size.height
            offsetX = (image.size.width - image.size.height) / 2
        } else {
            width = image.size.width
            height = image.size.width
            offsetY = (image.size.height - image.size.width) / 2
        }
        var cropRect = CGRectMake(offsetX, offsetY, width, height)
        var imageRef = CGImageCreateWithImageInRect(image.CGImage, cropRect)
        
        return UIImage(CGImage: imageRef)
    }
    

    
func verifyAndSubmit(scholar: PFObject) {
//        if count(self.age.text) != 0 {
//            scholar["age"] = self.age.text.toInt()
//        }
//        if count(self.gender.text) != 0 {
//            scholar["gender"] = self.gender.text
//        }
        if count(self.cityCountry.text) != 0 {
            scholar["location"] = self.cityCountry.text
        }
        if count(self.shortBio.text) != 0 {
            scholar["shortBio"] = self.shortBio.text
        }
        if count(self.appVideo.text) != 0 {
            scholar["videoLink"] = self.appVideo.text
        }
        if count(self.githubUsername.text) != 0 {
            scholar["github"] = self.githubUsername.text
        }
        if count(self.email.text) != 0 {
            scholar["email"] = self.email.text
        }
        if count(self.twitterUsername.text) != 0 {
            scholar["twitter"] = self.twitterUsername.text
        }
        if count(self.facebookUsername.text) != 0 {
            scholar["facebook"] = self.facebookUsername.text
        }
        if count(self.githubLink.text) != 0 {
            scholar["githubLinkApp"] = self.githubLink.text
        }
        if count(self.linkedinUsername.text) != 0 {
            scholar["linkedin"] = self.linkedinUsername.text
        }
        if count(self.websiteLink.text) != 0 {
            scholar["website"] = self.websiteLink.text
        }
        if count(self.itunesLink.text) != 0 {
            scholar["itunes"] = self.itunesLink.text
        }
//        if count(self.previousWWDC.text) != 0 {
//            let arr = self.previousWWDC.text.componentsSeparatedByString(", ")
//            scholar["numberOfTimesWWDCScholar"] = arr.count
//            scholar["batchWWDC"] = arr
//        }
//    if count(self.dateOfBirth.text) != 0 {
//        scholar["birthday"] = self.dateOfBirth.text
//    }
    if newImage {
        let squaredimage = self.squareImage(self.profpic.currentBackgroundImage!)
        let file = PFFile(name: "profilePic", data: UIImagePNGRepresentation(squaredimage))
        file.saveInBackground()
        scholar["profilePic"] = file
    }
    if let image = appScreenshot1.currentBackgroundImage {
        let file = PFFile(name: "screenshot1", data: UIImagePNGRepresentation(image))
        file.saveInBackground()
        scholar["screenshotOne"] = file
    }
    if let image = appScreenshot2.currentBackgroundImage {
        let file = PFFile(name: "screenshot2", data: UIImagePNGRepresentation(image))
        file.saveInBackground()
        scholar["screenshotTwo"] = file
    }
    if let image = appScreenshot3.currentBackgroundImage {
        let file = PFFile(name: "screenshot3", data: UIImagePNGRepresentation(image))
        file.saveInBackground()
        scholar["screenshotThree"] = file
    }
    if let image = appScreenshot4.currentBackgroundImage {
        let file = PFFile(name: "screenshot4", data: UIImagePNGRepresentation(image))
        file.saveInBackground()
        scholar["screenshotFour"] = file
    }
        self.performSegueWithIdentifier("backToMain", sender: self)
        scholar.saveInBackground()
    PFUser.logOutInBackground()
    }

func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if screenshot == 1 {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        appScreenshot1.contentMode = .ScaleAspectFit //3
        appScreenshot1.setBackgroundImage(chosenImage, forState: UIControlState.Normal) //4
            appScreenshot1.setTitle("", forState: UIControlState.Normal)

        dismissViewControllerAnimated(true, completion: nil) //5
        }
        if screenshot == 2 {
            var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            appScreenshot2.contentMode = .ScaleAspectFit //3
            appScreenshot2.setBackgroundImage(chosenImage, forState: UIControlState.Normal) //4
            appScreenshot2.setTitle("", forState: UIControlState.Normal)

            dismissViewControllerAnimated(true, completion: nil) //5
        }
        if screenshot == 3 {
            var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            appScreenshot3.contentMode = .ScaleAspectFit //3
            appScreenshot3.setBackgroundImage(chosenImage, forState: UIControlState.Normal) //4
            appScreenshot3.setTitle("", forState: UIControlState.Normal)

            dismissViewControllerAnimated(true, completion: nil) //5
        }
        if screenshot == 4 {
            var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            appScreenshot4.contentMode = .ScaleAspectFit //3
            appScreenshot4.setBackgroundImage(chosenImage, forState: UIControlState.Normal) //4
            appScreenshot4.setTitle("", forState: UIControlState.Normal)
            dismissViewControllerAnimated(true, completion: nil) //5
        }
        if screenshot == 5 {
            var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            profpic.contentMode = .ScaleAspectFit //3
            profpic.setBackgroundImage(chosenImage, forState: UIControlState.Normal) //4
            profpic.setTitle("", forState: UIControlState.Normal)
            newImage = true
            dismissViewControllerAnimated(true, completion: nil) //5
        }


    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.delegate = self
        
        // Do any additional setup after loading the view.
        scrollView.scrollEnabled = true
        scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1746)
//        scrollView.showsVerticalScrollIndicator = true
        
        screenshotScrollview.scrollEnabled = true
        screenshotScrollview.contentSize = CGSizeMake(600, 249)
//        screenshotScrollview.showsHorizontalScrollIndicator = true

        profpic.layer.cornerRadius = 10
        profpic.layer.masksToBounds = true
        
        
//        let paddingView3 = UIView(frame: CGRectMake(0, 0, 8, self.age.frame.height))
//        age.leftView = paddingView3
//        age.leftViewMode = UITextFieldViewMode.Always
//        let paddingView4 = UIView(frame: CGRectMake(0, 0, 8, self.dateOfBirth.frame.height))
//        dateOfBirth.leftView = paddingView4
//        dateOfBirth.leftViewMode = UITextFieldViewMode.Always
//        let paddingView5 = UIView(frame: CGRectMake(0, 0, 8, self.gender.frame.height))
//        gender.leftView = paddingView5
//        gender.leftViewMode = UITextFieldViewMode.Always
//        let paddingView6 = UIView(frame: CGRectMake(0, 0, 8, self.cityCountry.frame.height))
//        cityCountry.leftView = paddingView6
//        cityCountry.leftViewMode = UITextFieldViewMode.Always
//        let paddingView7 = UIView(frame: CGRectMake(0, 0, 8, self.previousWWDC.frame.height))
//        previousWWDC.leftView = paddingView7
//        previousWWDC.leftViewMode = UITextFieldViewMode.Always
//        let paddingView8 = UIView(frame: CGRectMake(0, 0, 8, self.appVideo.frame.height))
//        appVideo.leftView = paddingView8
//        appVideo.leftViewMode = UITextFieldViewMode.Always
//        let paddingView9 = UIView(frame: CGRectMake(0, 0, 8, self.githubLink.frame.height))
//        githubLink.leftView = paddingView9
//        githubLink.leftViewMode = UITextFieldViewMode.Always
//        let paddingView10 = UIView(frame: CGRectMake(0, 0, 8, self.email.frame.height))
//        email.leftView = paddingView10
//        email.leftViewMode = UITextFieldViewMode.Always
//        let paddingView11 = UIView(frame: CGRectMake(0, 0, 8, self.twitterUsername.frame.height))
//        twitterUsername.leftView = paddingView11
//        twitterUsername.leftViewMode = UITextFieldViewMode.Always
//        let paddingView12 = UIView(frame: CGRectMake(0, 0, 8, self.facebookUsername.frame.height))
//        facebookUsername.leftView = paddingView12
//        facebookUsername.leftViewMode = UITextFieldViewMode.Always
//        let paddingView13 = UIView(frame: CGRectMake(0, 0, 8, self.githubUsername.frame.height))
//        githubUsername.leftView = paddingView13
//        githubUsername.leftViewMode = UITextFieldViewMode.Always
//        let paddingView14 = UIView(frame: CGRectMake(0, 0, 8, self.linkedinUsername.frame.height))
//        linkedinUsername.leftView = paddingView14
//        linkedinUsername.leftViewMode = UITextFieldViewMode.Always
//        let paddingView15 = UIView(frame: CGRectMake(0, 0, 8, self.websiteLink.frame.height))
//        websiteLink.leftView = paddingView15
//        websiteLink.leftViewMode = UITextFieldViewMode.Always
//        let paddingView16 = UIView(frame: CGRectMake(0, 0, 8, self.itunesLink.frame.height))
//        itunesLink.leftView = paddingView16
//        itunesLink.leftViewMode = UITextFieldViewMode.Always
//        shortBio.delegate = self
        
        
        
        //Save Button
        saveButton.layer.cornerRadius = 7
        saveButton.layer.borderWidth = 0.5
        saveButton.layer.borderColor = UIColorFromRGB(0x593A8F).CGColor
        shortBio.text = ""
        shortBioCharactersLeft.text = "0/250 characters left"
        
        
        
        
        
        
        
        //PARSE PULLING OF OBJECTS
        
        
        let query = PFQuery(className: "scholars")
        //query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            if let loadedUser = object {
                self.user = loadedUser
                self.name.text = (loadedUser["firstName"] as! String) + " " + (loadedUser["lastName"] as! String)
                self.ageLabel.text = String(stringInterpolationSegment: loadedUser["age"] as! NSNumber)
                
                
                let date: NSDate = loadedUser["birthday"] as! NSDate
                let formatter = NSDateFormatter()
                formatter.dateFormat = "MM/DD/YYYY"
                self.birthdayLabel.text = formatter.stringFromDate(date)
                
                self.genderLabel.text = loadedUser["gender"] as? String
                
                
                
//                self.age.text = String(stringInterpolationSegment: loadedUser["age"] as! NSNumber)
//                
//                self.dateOfBirth.text = formatter.stringFromDate(date)
//                self.gender.text = loadedUser["gender"] as? String
                
                
                self.cityCountry.text = loadedUser["location"] as? String
                self.shortBio.text = loadedUser["shortBio"] as? String
//            self.previousWWDC.text = ", ".join((loadedUser["batchWWDC"] as! [String]))
                self.appVideo.text = loadedUser["videoLink"] as? String
                self.githubLink.text = loadedUser["githubLinkApp"] as? String
                self.email.text = loadedUser["email"] as? String
                self.twitterUsername.text = loadedUser["twitter"] as? String
                self.facebookUsername.text = loadedUser["facebook"] as? String
                self.githubUsername.text = loadedUser["github"] as? String
                self.linkedinUsername.text = loadedUser["linkedin"] as? String
                self.websiteLink.text = loadedUser["website"] as? String
                self.itunesLink.text = loadedUser["itunes"] as? String
                (loadedUser["profilePic"] as! PFFile).getDataInBackgroundWithBlock({ (data, error) -> Void in
                    if let picData = data {
                        self.profpic.setBackgroundImage(UIImage(data: picData), forState: UIControlState.Normal)
                    }
                })
            }
        }
        
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
