//
//  MapManager.swift
//  SpotJournal
//
//  Created by Anton Siauruk on 5/18/19.
//  Copyright © 2019 Anton Siauruk. All rights reserved.
//

import UIKit
import MapKit

class MapManager {
    
    let locationManager = CLLocationManager()
    
    private var spotCoordinate: CLLocationCoordinate2D?
    private let regionInMeters = 1000.00
    
    
    //  Spot placemark
    func setupPlacemark(spot: Spot, mapView: MKMapView) {
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
            annotation.title = spot.name
            annotation.subtitle = spot.type
            
            guard let placemarkLocation = placemark?.location else { return }
            
            annotation.coordinate = placemarkLocation.coordinate
            self.spotCoordinate = placemarkLocation.coordinate
            
            mapView.showAnnotations([annotation], animated: true)
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    //  Сheck the availability of geolocation services
    func checkLocationServices(mapView: MKMapView, segueIdentifier: String, closure: () -> ()) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            checkLocationAuthorization(mapView: mapView, segueIdentifier: segueIdentifier)
            closure()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showAlert(title: "Location Services Off", message: "Turn on Location Services in Settings > Privacy to allow Spot Journal to determinate your current location")
            }
            
        }
    }
    
    //  Application authorization check for using geolocation services
    func checkLocationAuthorization(mapView: MKMapView, segueIdentifier: String) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            if segueIdentifier == "getAddress" { showUserLocation(mapView: mapView) }
        case .denied:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showAlert(title: "Your Location is not Available", message: "Turn on Location Services in Settings > SpotJournal to allow Spot Journal to determinate your current location")
            }
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            print("New case is available")
        }
    }
    
    //  Map focus on user's location
    func showUserLocation(mapView: MKMapView) {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    //  Bulid a route from the user's location to the spot using Apple Maps
    func openMapForPlace(placeName: String) {
        guard let destination = createDestinationMapItem() else {
            showAlert(title: "Error", message: "Destination is not found")
            return
        }

        destination.name = placeName
        destination.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    //  Create destination MKMapItem
    func createDestinationMapItem() -> MKMapItem? {
        guard let destinationCoordinate = spotCoordinate  else { return nil }
        var destination: MKPlacemark
        
        if #available(iOS 10.0, *) {
            destination = MKPlacemark(coordinate: destinationCoordinate)
        } else {
            destination = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)
        }
        
        return MKMapItem(placemark: destination)
    }
    
    //  Сhange the displayed area of ​​the map area in accordance with the user's movement
    func startTrackingUserLocation(for mapView: MKMapView, and location: CLLocation?, closure: (_ currentLocation: CLLocation) -> ()) {
        guard let location = location else { return }
        let center = getCenterLocation(for: mapView)
        guard center.distance(from: location) > 50 else { return }
        
        closure(center)
    }
    
    //  Get the center of the displayed map area
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    //  Show a simple alert with two UIAlertActions
    func showAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            // If location settings are enabled then open location settings for the app
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        
        alert.addAction(settingsAction)
        alert.addAction(okAction)
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true)
    }
    
    deinit {
        print("deinit", MapManager.self)
    }
    
}
