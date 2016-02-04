//
//  ViewController.swift
//  GetOnThatBus
//
//  Created by Danny Vasquez on 2/2/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController, MKMapViewDelegate {
    let locationManager = CLLocationManager()
    var busStops = [NSDictionary]()
    var stops = [stopInfo]()
    var annotations = [MKPointAnnotation]()
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
//        dropPinForLocation("Yosemite National Park")
        let url = NSURL(string: "https://s3.amazonaws.com/mmios8week/bus.json")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            do {
                let stopsDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                self.busStops = stopsDictionary.objectForKey("row") as! [NSDictionary]
                print(self.busStops.first)
                
                for busStop:NSDictionary in self.busStops {
                    let value = stopInfo(busStopDictionary: busStop)
                    self.stops.append(value)
                }
                
                
            }
            catch let error as NSError{
                print("JSONError: \(error.localizedDescription)")
            }
            for value in self.stops {
                self.dropPinForLocation(value)
                

            }
        }
        
        task.resume()
    }
 
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        mapView.setRegion(MKCoordinateRegionMake(view.annotation!.coordinate, MKCoordinateSpanMake(0.1, 0.1)), animated: true)
//                self.mapView.showAnnotations(self.mapView.annotations, animated: true)

        //this method allows us to tap on the annotation title and automatically zoom in for an even closer look//
    }

    func dropPinForLocation(address: stopInfo) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(address.latitude, address.longitude)
        annotation.title = address.stopName
        annotation.subtitle = "Routes: \(address.routes)"
        self.mapView.addAnnotation(annotation)
        self.annotations.append(annotation)
//        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        return pin

    }
}




//func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//    if annotation.isEqual(mapView.userLocation) {
//        return nil
//    }else if annotation.isEqual(mobileMakersAnnotation) {
//        let pin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
//        pin.image = UIImage(named: "mm")
//        pin.canShowCallout = true
//        pin.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
//        return pin
//        
//    }else {
//        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
//        pin.canShowCallout = true
//        pin.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
//        
//        return pin // look down for description of what this does//
//        
//    }
//}
//






//                for busStop in self.busStops
//                {
//                    self.dropPinForLocation(busStop)
//                    if busStop.longitude > 0
//                    {
//                        busStop.longitude = -(busStop.longitude)
//                    }
//                    self.averageLatitude = self.averageLatitude + busStop.latitude
//                    self.averageLongitude = self.averageLongitude + busStop.longitude
//                }
//                self.averageLatitude = self.averageLatitude / Double(self.busStops.count)
//                self.averageLongitude = self.averageLongitude / Double(self.busStops.count)
//                self.centerAnnotation.coordinate = CLLocationCoordinate2DMake(self.averageLatitude, self.averageLongitude)
//                self.mapView.setRegion(MKCoordinateRegionMake(self.centerAnnotation.coordinate, MKCoordinateSpanMake(0.3, 0.3)), animated: true)


