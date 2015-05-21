//
//  ViewController.swift
//  WWDC Scholars 2015
//
//  Created by Gelei Chen on 15/5/20.
//  Copyright (c) 2015 WWDC-Scholars. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class LocationViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    //init the model
    var scholarArray:[Scholar] = [Scholar(name: "Gelei Chen", age: "19", birthdate: "", gender: "", latitude: 40.4240, longitude: -86.9290, email: "", picture: "", numberOfWWDCAttend: "", appDemo: "", githubLinkToApp: "", twitter: "", facebook: "", github: "", linkedIn: "", website: ""),Scholar(name: "IU", age: "", birthdate: "", gender: "", latitude: 39.1768, longitude: -86.5197, email: "", picture: "", numberOfWWDCAttend: "", appDemo: "", githubLinkToApp: "", twitter: "", facebook: "", github: "", linkedIn: "", website: ""),Scholar(name: "Michigan", age: "", birthdate: "", gender: "", latitude: 43.6867, longitude: -85.0102, email: "", picture: "", numberOfWWDCAttend: "", appDemo: "", githubLinkToApp: "", twitter: "", facebook: "", github: "", linkedIn: "", website: ""),Scholar(name: "UIUC", age: "", birthdate: "", gender: "", latitude: 40.1105, longitude: -88.2284, email: "", picture: "", numberOfWWDCAttend: "", appDemo: "", githubLinkToApp: "", twitter: "", facebook: "", github: "", linkedIn: "", website: "")]
    var currentScholar:Scholar?
    
    var qTree = QTree()
    var myLocation : CLLocationCoordinate2D?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !CLLocationManager.locationServicesEnabled() {
            self.locationManager.requestWhenInUseAuthorization()
        }
        
        myLocation = mapView.userLocation.coordinate as CLLocationCoordinate2D
        
        let zoomRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 38.8833, longitude: -77.0167), 10000000, 10000000)
        self.mapView.setRegion(zoomRegion, animated: true)
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        //The "Find me" button
        let button = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        button.frame = CGRectMake(UIScreen.mainScreen().bounds.width - 70, self.view.frame.height - 90, 50, 50)
        button.setImage(UIImage(named: "MyLocation"), forState: .Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSizeMake(0, 0)
        button.layer.shadowRadius = 2
        self.view.addSubview(button)
        
        for scholar in scholarArray {
            
            let annotation = scholarAnnotation(coordinate: CLLocationCoordinate2DMake(scholar.latitude, scholar.longitude), title: scholar.name!,subtitle:"test")
            self.qTree.insertObject(annotation)
            
            //self.mapView.addAnnotation(annotation)
        }
        self.reloadAnnotations()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func buttonAction(sender:UIButton!)
    {
        let myLocation = mapView.userLocation.coordinate as CLLocationCoordinate2D
        let zoomRegion = MKCoordinateRegionMakeWithDistance(myLocation,10000,10000)
        self.mapView.setRegion(zoomRegion, animated: true)
    }
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation.isKindOfClass(QCluster.classForCoder()) {
            let PinIdentifier = "PinIdentifier"
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(ClusterAnnotationView.reuseId()) as? ClusterAnnotationView
            if annotationView == nil {
                annotationView = ClusterAnnotationView(cluster: annotation)
            }
            annotationView!.canShowCallout = true
            annotationView!.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIButton
            annotationView!.cluster = annotation
            return annotationView
        }
        return nil
    }
    
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        for scholar in scholarArray {
            /*
            if job.title == (view.annotation as! JobAnnotation).title {
                self.currentJob = job
                self.performSegueWithIdentifier("transformToScholarDetail", sender: self)
            }
            */
        }
    }
    
    func reloadAnnotations(){
        if self.isViewLoaded() == false {
            return
        }
        let mapRegion = self.mapView.region
        let minNonClusteredSpan = min(mapRegion.span.latitudeDelta, mapRegion.span.longitudeDelta) / 5
        let objects = self.qTree.getObjectsInRegion(mapRegion, minNonClusteredSpan: minNonClusteredSpan) as NSArray
        let annotationsToRemove = (self.mapView.annotations as NSArray).mutableCopy() as! NSMutableArray
        annotationsToRemove.removeObject(self.mapView.userLocation)
        annotationsToRemove.removeObjectsInArray(objects as [AnyObject])
        self.mapView.removeAnnotations(annotationsToRemove as [AnyObject])
        let annotationsToAdd = objects.mutableCopy() as! NSMutableArray
        annotationsToAdd.removeObjectsInArray(self.mapView.annotations)
        
        self.mapView.addAnnotations(annotationsToAdd as [AnyObject])
        
        
    }
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        self.reloadAnnotations()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "transformToScholarDetail" {
            /*
            let viewController = segue.destinationViewController as! JobDetailViewController
            viewController.currentJob = currentJob
            */
        }
        
    }
    
}
