//
//  MapViewController.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 5/13/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var spot = Spot()

    @IBOutlet var mapView: MKMapView!
    
    @IBAction func closeVC() {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlacemark()
    }
    
    private func setupPlacemark() {
        guard let location = spot.location else { return }
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = self.spot.name
            annotation.subtitle = self.spot.type
            
            guard let placemarkLocation = placemark?.location else { return }
            
            annotation.coordinate = placemarkLocation.coordinate
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
}
