//
//  ViewController.swift
//  FrameworksDemo
//
//  Created by Harley Trung on 12/21/15.
//  Copyright © 2015 cheetah.com. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var myMapView: MKMapView!
    let geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMapView.showsUserLocation = true
        myMapView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserverForName("notifyUpdatedLocation", object: nil, queue: NSOperationQueue.mainQueue()) { (notification: NSNotification) -> Void in
            let userInfo = notification.userInfo as! [String: AnyObject]
            let location = userInfo["location"]! as! CLLocation
            print("notified: ", location)
            
            let center = location.coordinate
            let viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(center, 1000, 1000)
            //            MKCoordinateRegionMake(center, MKCoordinateSpanMake(20, 20))
            
            // Configure the map
            self.myMapView.setRegion(viewRegion, animated: true)
            
            self.geocoder.reverseGeocodeLocation(location, completionHandler: { (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                let placemark = placemarks![0] as CLPlacemark
                print("placemark: ", placemark)
            })
        }
    }
    //
    //    func addPin() {
    //        let annotation = MKPointAnnotation()
    //        let location = CLLocationCoordinate2D
    //        let locationCoordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

