//
//  ViewController.swift
//  ExapleProject
//
//  Created by Alex Zimin on 29/05/15.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var contentView: UIView!
    
    let numberOfScreens: CGFloat = 6
    
    @IBOutlet weak var contentViewWidthConstraint: NSLayoutConstraint! {
        didSet {
            contentViewWidthConstraint.constant = screenSize.width * numberOfScreens
        }
    }
    
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint! {
        didSet {
            contentViewHeightConstraint.constant = screenSize.height
        }
    }
    
    var screenSize: CGSize {
        return UIScreen.mainScreen().bounds.size
    }
    
    var objects: [TutorialObject] = []
    
    var quoteLabel: TOMSMorphingLabel!
    
    var first = "The misfits. The rebels. The troublemakers. The round pegs in the square holes. The ones who see things differently. We're not fond of rules. And we have no respect for the status quo."
    var second = "You can quote us, disagree with us, glorify or vilify us. About the only thing you can't do is ignore us. Because we change things. We push the human race forward."
    var third = "And while some may see us as the crazy ones, we see genius. Because the people who are crazy enough to think they can change the world, are the ones who do."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObjects()
        
        pageControl.numberOfPages = Int(numberOfScreens)
    }
    
    func addObjects() {
        
        addQuote()
        addParagraph(first, atIndex: 0)
        addParagraph(second, atIndex: 1)
        addParagraph(third, atIndex: 2)
        addLogoObject()
        addOthersElemts()
        
        objects.map() { $0.changeObjectToPosition(self.scrollView.contentOffset) }
    }
    
    func addLogoObject() {
        let imageView = UIImageView(image: UIImage(named: "scholarIconBig"))
        imageView.center = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        contentView.addSubview(imageView)
        
        let logoObject = TutorialObject(object: imageView)
        logoObject.setPoints([CGPoint(x: 4.5, y: 0.85), CGPoint(x: 5.5, y: 0.35)])
        
        let bigLogoSize = screenSize.width - 100
        let smallLogoSize = screenSize.width / 3
        logoObject.addActionAtPosition(TutorialObjectAction.Resize(size: CGSize(width: smallLogoSize, height: smallLogoSize)), position: 0)
        logoObject.addActionAtPosition(TutorialObjectAction.Resize(size: CGSize(width: bigLogoSize, height: bigLogoSize)), position: 1)
        
        objects.append(logoObject)
    }
    
    func addOthersElemts() {
        let imageView = UIImageView(image: UIImage(named: "wwdc_text_image"))
        imageView.center = CGPoint(x: screenSize.width * 5.5, y: screenSize.height / 1.4)
        contentView.addSubview(imageView)
        
        let anotheQuoteLabel = UILabel(frame: CGRectMake(0, 0, screenSize.width - 32, 30))
        anotheQuoteLabel.center = CGPoint(x: screenSize.width / 2, y: screenSize.height / 1.8)
        anotheQuoteLabel.text = "-Steve Jobs"
        anotheQuoteLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        anotheQuoteLabel.textAlignment = .Right
        contentView.addSubview(anotheQuoteLabel)
        
        let startButton = UIButton(frame: CGRectMake(0, 0, imageView.frame.width, imageView.frame.height))
        startButton.center = CGPoint(x: screenSize.width * 5.5, y: screenSize.height / 1.2)
        startButton.backgroundColor = UIColor.purpleColor()
        startButton.setTitle("Start", forState: .Normal)
        startButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        contentView.addSubview(startButton)
    }
    
    func buttonAction(sender:UIButton!)
    {
        self.performSegueWithIdentifier("toMain", sender: self)
    }

    
    func addQuote() {
        var font = UIFont(name: "HelveticaNeue-Thin", size: 24)!
        let firstPartAttributes = AZTextFrameAttributes(string: "Here's ", font: font)
        let secondPartAttributes = AZTextFrameAttributes(string: "   the Crazy Ones", font: font)
        let defaultPartAttributes = AZTextFrameAttributes(string: first + "\n\n", width: screenSize.width - 16, font: UIFont(name: "HelveticaNeue-Thin", size: 18)!)
        
        let firstWidth = AZTextFrame(attributes: firstPartAttributes).width
        let secondWidth = AZTextFrame(attributes: secondPartAttributes).width
        let defaultPartHeight = AZTextFrame(attributes: defaultPartAttributes).height
        let sum = firstWidth + secondWidth
        
        var fullSpace = sum / screenSize.width
        var firstSpace: CGFloat = fullSpace / 2 - (firstWidth / screenSize.width) / 2
        var secondSpace: CGFloat = -fullSpace / 2 + (firstWidth / screenSize.width) + (secondWidth / screenSize.width) / 2
        
        var coefficent = 0.5 - (defaultPartHeight / screenSize.height) / 2
        
        quoteLabel = TOMSMorphingLabel(frame: CGRectMake(0, 0, firstWidth + 22, 30))
        quoteLabel.font = font
        quoteLabel.center =  CGPoint(x: screenSize.width / 2 - screenSize.width * firstSpace, y: 0)
        quoteLabel.text = "Here's to "
        quoteLabel.textAlignment = .Right
        contentView.addSubview(quoteLabel)
        
        let quoteObject = TutorialObject(object: quoteLabel)
        quoteObject.setPoints([CGPoint(x: 0.5 - firstSpace, y: 0.5), CGPoint(x: 1.5 - firstSpace, y: 0.5), CGPoint(x: 2.5 - firstSpace, y: coefficent), CGPoint(x: 3.5 - firstSpace, y: -0.1)])
        objects.append(quoteObject)
        
        let anotheQuoteLabel = UILabel(frame: CGRectMake(0, 0, secondWidth, 30))
        anotheQuoteLabel.center =  CGPoint(x: screenSize.width / 2 + screenSize.width * secondSpace, y: 0)
        anotheQuoteLabel.text = "   the Crazy Ones"
        anotheQuoteLabel.font = font
        anotheQuoteLabel.textAlignment = .Left
        contentView.addSubview(anotheQuoteLabel)
        
        let anotherQuoteObject = TutorialObject(object: anotheQuoteLabel)
        anotherQuoteObject.setPoints([CGPoint(x: 0.5 + secondSpace, y: 0.5), CGPoint(x: 1.5 + secondSpace, y: 0.5), CGPoint(x: 2.5 + secondSpace, y: coefficent), CGPoint(x: 3.5 + secondSpace, y: -0.1)])
        objects.append(anotherQuoteObject)
    }
    
    func addParagraph(value: String, atIndex index: Int) {
        let label = UILabel(frame: CGRectMake(0, 0, screenSize.width - 16, screenSize.height))
        label.center =  CGPoint(x: screenSize.width * 0.5, y: 0)
        label.text = value
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        label.textAlignment = .Center
        contentView.addSubview(label)
        
        let labelObject = TutorialObject(object: label)
        
        var points = [CGPoint(x: 1.5 + CGFloat(index), y: 0.9), CGPoint(x: 2.5 + CGFloat(index), y: 0.5), CGPoint(x: 3.5 + CGFloat(index), y: 0.1)]
        if index == 0 {
            points.removeAtIndex(0)
        }
        labelObject.setPoints(points)
        
        if index == 0 {
            labelObject.addActionAtPosition(TutorialObjectAction.ChangeAlpha(value: 1.0), position: 0)
            labelObject.addActionAtPosition(TutorialObjectAction.ChangeAlpha(value: 0.1), position: 1)
            labelObject.tag = 1
        } else {
            labelObject.addActionAtPosition(TutorialObjectAction.ChangeAlpha(value: 0.1), position: 0)
            labelObject.addActionAtPosition(TutorialObjectAction.ChangeAlpha(value: 1.0), position: 1)
            labelObject.addActionAtPosition(TutorialObjectAction.ChangeAlpha(value: index == 2 ? 0.0 : 0.1), position: 2)
        }
        
        
        objects.append(labelObject)
    }
    
    var lastContentOffset: CGPoint = CGPointZero
    var textState = 0
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updatePageControl()
        
        var firstLabel: UILabel?
        objects.map() {
            tutorialObject -> () in
            if tutorialObject.tag == 1 {
                firstLabel = tutorialObject.object as? UILabel
            }
            tutorialObject.changeObjectToPosition(scrollView.contentOffset)
        }
        
        if let label = firstLabel {
            if scrollView.contentOffset.x > screenSize.width * 1.0 && scrollView.contentOffset.x < screenSize.width * 2.0 {
                label.alpha = (scrollView.contentOffset.x - screenSize.width) / screenSize.width
            }
        }
        
        if scrollView.contentOffset.x > lastContentOffset.x && scrollView.contentOffset.x > screenSize.width * 0.5 {
            if self.quoteLabel.text != "We are " {
                self.quoteLabel.setText("We are ", withCompletionBlock: nil)
            }
        } else if scrollView.contentOffset.x < lastContentOffset.x && scrollView.contentOffset.x < screenSize.width * 0.5 {
            if self.quoteLabel.text != "Here's to " {
                self.quoteLabel.setText("Here's to ", withCompletionBlock: nil)
            }
        }
        
        lastContentOffset = scrollView.contentOffset
    }
    
    func updatePageControl() {
        var pageNumber = Int(round((scrollView.contentOffset.x / screenSize.width)))
        pageNumber = min(max(0, pageNumber), Int(numberOfScreens - 1))
        pageControl.currentPage = pageNumber
    }
}

