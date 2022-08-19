//
//  placesMapViewController.swift
//  ex00
//
//  Created by Андрей Мотырев on 18.08.2022.
//

import Foundation
import MapKit

class placesMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {
    var location = CLLocationManager()
    var trackingEnable = false
    var placeToShow: MKAnnotation = PlacesList.places.first!
    
    @IBOutlet weak var placesMapView: MKMapView!    {
        didSet  {
            placesMapView.delegate = self
        }
    }
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    
    @IBOutlet weak var LocationOutlet: UIButton!
    
    @IBAction func LocationAction(_ sender: UIButton) {
        if (trackingEnable) {
            location.startUpdatingLocation()
        }   else    {
            location.startUpdatingLocation()
        }
        trackingEnable = !trackingEnable
        locationButtonUpdate()
    }
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        switch (segmentOutlet.selectedSegmentIndex) {
            case 1 :
                placesMapView.mapType = MKMapType.satellite
            case 2 :
                placesMapView.mapType = MKMapType.hybrid
            default:
                placesMapView.mapType = MKMapType.standard
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        location.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch location.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                    location.requestWhenInUseAuthorization()
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Access")
                @unknown default:
                    break
            }
        } else {
            print("Location services are not enabled")
        }
        
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        location.distanceFilter = 5
        
        placesMapView.isZoomEnabled = true
        placesMapView.addAnnotations(PlacesList.places)
        showPlace(coordinate: placeToShow.coordinate)
        locationButtonUpdate()
    }

    func showAlertLocation()    {
        let alert = UIAlertController(title: "Turn on GPS", message: "Would?", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default){ (alert) in
            if let url = URL(string: "App-Prefs:root=LOCATION_SERVICES")    {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(settingsAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showPlace(coordinate: CLLocationCoordinate2D) {
        var region = MKCoordinateRegion()
        region.center = coordinate
        region.span.latitudeDelta = 0.01;
        region.span.longitudeDelta = 0.01;
        placesMapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = manager.location?.coordinate else {
            return
        }
        showPlace(coordinate: coordinate)
    }
    
    func locationButtonUpdate() {
        LocationOutlet.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        LocationOutlet.layer.borderWidth = 2
        LocationOutlet.layer.cornerRadius = LocationOutlet.frame.width / 2
        if trackingEnable {
            LocationOutlet.layer.borderColor = UIColor.systemBlue.cgColor
        } else {
            LocationOutlet.tintColor = .systemGray
            LocationOutlet.layer.borderColor = UIColor.systemGray.cgColor
        }
    }
}
