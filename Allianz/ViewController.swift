//
//  ViewController.swift
//  Allianz
//
//  Created by Rodolfo Castillo on 12/20/16.
//  Copyright © 2016 Mariachis. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    
    var locManager: CLLocationManager!
    var lastPin: MKPointAnnotation!
    var lat: CLLocationDegrees!
    var lon: CLLocationDegrees!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.map.delegate = self
        
        self.locManager = CLLocationManager()
        self.locManager.delegate = self
        self.locManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locManager.requestWhenInUseAuthorization()
        self.locManager.requestLocation()
        
        self.searchButton.addTarget(self, action: #selector(self.performSearch(_:)), for: .touchUpInside)
        self.searchView.layer.shadowOpacity = 0.6
        self.searchView.layer.shadowColor = UIColor.black.cgColor
        self.searchView.layer.shadowRadius = 2
        self.searchView.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func performSearch(_ sender: AnyObject){
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = self.searchBar.text!
        request.region = map.region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else {
                print("Search error: \(error)")
                return
            }
            
            for item in response.mapItems {
                print(item)
                self.addAnnotationForMap(item)
            }
        }
        self.searchBar.resignFirstResponder()
    }
    
    func validatedAdress() -> Bool { // STILL THINGS TO DO HERE
        if searchBar.text != "" {
            return true
        } else {
            return false
        }
    }

}

extension ViewController {
    
    @objc(locationManager:didChangeAuthorizationStatus:) func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            if let location = locations.first {
                let span = MKCoordinateSpanMake(0.005, 0.005)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                self.map.setRegion(region, animated: true)
                self.addAnnotationForMap(MKMapItem(placemark: MKPlacemark(coordinate: location.coordinate, addressDictionary: nil)))
            }
            print("location:: \(location)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
    @objc(mapView:viewForAnnotation:) func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.image = UIImage(named:"xaxas")
            anView!.canShowCallout = true
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView!.annotation = annotation
        }
        
        return anView
    }
    
    func addAnnotationForMap(_ MapItem: MKMapItem){
        if self.lastPin != nil {
            self.map.removeAnnotation(lastPin)
        }
        let myPin = MKPointAnnotation()
        myPin.coordinate = MapItem.placemark.coordinate
        myPin.title = MapItem.placemark.title
        self.map.addAnnotation(myPin)
        self.lastPin = myPin
        self.lat = myPin.coordinate.latitude
        self.lon = myPin.coordinate.longitude
        
        
        
        self.getLocation(CLLocation(latitude: myPin.coordinate.latitude, longitude: myPin.coordinate.longitude))
        
        let anView:MKAnnotationView = MKAnnotationView()
        anView.annotation = myPin
        anView.canShowCallout = true
        anView.isEnabled = true
        
        self.map.showAnnotations([myPin], animated: true)
        
    }
    
    
    
    func getLocation(_ location: CLLocation){
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            print(location)
            
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                
                let adressItems : [AnyObject?] = [pm.thoroughfare as Optional<AnyObject>, pm.subThoroughfare as Optional<AnyObject>, pm.postalCode as Optional<AnyObject>, pm.subLocality as Optional<AnyObject>, pm.subAdministrativeArea as Optional<AnyObject>, pm.administrativeArea as Optional<AnyObject>, pm.locality as Optional<AnyObject>]
                
                var adressString = ""
                var auxFlag = 0
                
                for StringItem in adressItems {
                    if let aux = StringItem {
                        
                        if auxFlag >= 1 {
                            if auxFlag == adressItems.count - 1 {
                                adressString = adressString + "\(aux)."
                            }
                            adressString = adressString + "\(aux), "
                        } else {
                            adressString = adressString + "\(aux) "
                        }
                        
                        
                    }
                    auxFlag += 1
                }
                
                print(adressString)
                self.searchBar.text = adressString
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            else {
                print("Problem with the data received from geocoder")
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        })
    }//

}

