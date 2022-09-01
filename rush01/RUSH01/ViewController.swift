//
//  ViewController.swift
//  RUSH01
//
//  Created by Zuleykha Pavlichenkova on 24.08.2022.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var currentPlace: Place = Place(name: "Школа 21, Казань", subtitle: "💻", longitude: 49.12517720093447, latitude: 55.7820829841939)
    var locationManager:CLLocationManager = CLLocationManager()
    var annotationsArray = [MKPointAnnotation]()


    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    // MARK: Buttons
    
    let addAddressButton: UIButton = {
        let button = UIButton()
        let buttonSizeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
        button.setImage(
            UIImage(systemName: "pencil.circle.fill", withConfiguration: buttonSizeConfig)?
                .withTintColor(.systemPink, renderingMode: .alwaysOriginal),
            for: .normal
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let locationButton: UIButton = {
        let button = UIButton()
        let buttonSizeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large)
        button.setImage(
            UIImage(systemName: "target", withConfiguration: buttonSizeConfig)?
                .withTintColor(.systemTeal, renderingMode: .alwaysOriginal),
            for: .normal
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didLocationButtonTapped), for: .touchUpInside)
        return button
    }()
        
    let routeButton: UIButton = {
        let button = UIButton()
        let buttonSizeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
        button.setImage(
            UIImage(systemName: "map.fill", withConfiguration: buttonSizeConfig)?
                .withTintColor(.systemPink, renderingMode: .alwaysOriginal),
            for: .normal
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()

    let resetButton: UIButton = {
        let button = UIButton()
        let buttonSizeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
        button.setImage(
            UIImage(systemName: "trash.circle.fill", withConfiguration: buttonSizeConfig)?
                .withTintColor(.systemPink, renderingMode: .alwaysOriginal),
            for: .normal
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()

    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        setConstraints()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        addAddressButton.addTarget(self, action: #selector(addAddressButtonTapped), for: .touchUpInside)
        routeButton.addTarget(self, action: #selector(routeButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    @objc func addAddressButtonTapped() {
        alertAddAddress(title: "Add Address", placeholder: "Input an address") { [self] (text) in
            setUpPlaceMark(addressPlace: text)
        }
    }
    
    @objc func didLocationButtonTapped() {
        showLocation(with: currentPlace)
        resetButton.isHidden = false
    }

    @objc func routeButtonTapped() {
        
        for index in 0..<annotationsArray.count - 1 {
            createDirectionRequest(start: annotationsArray[index].coordinate, finish: annotationsArray[index + 1].coordinate)
        }
        mapView.showAnnotations(annotationsArray, animated: true)
        resetButton.isHidden = false
    }
    
    @objc func resetButtonTapped() {
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        annotationsArray = [MKPointAnnotation]()
        routeButton.isHidden = true
        resetButton.isHidden = true

    }
    
    private func setUpPlaceMark(addressPlace: String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(addressPlace) { [self] (placeMark, error) in
            if let error = error {
                print(error)
                alertError(title: "Error", message: "Service is unavailable at the moment. Try again later.")
                return
            }
            guard let placeMarks = placeMark else {return}
            let placeMark = placeMarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = addressPlace
            guard let placeMarkLocation = placeMark?.location else {return}
            annotation.coordinate = placeMarkLocation.coordinate
        
            annotationsArray.append(annotation)
            
            if annotationsArray.count > 1 {
                routeButton.isHidden = false
                resetButton.isHidden = false
            }
            
            mapView.showAnnotations(annotationsArray, animated: true)
            resetButton.isHidden = false
        }
    }
    
    // MARK: createDirectionRequest
    
    private func createDirectionRequest(start: CLLocationCoordinate2D, finish: CLLocationCoordinate2D) {
        
        let startLocation = MKPlacemark(coordinate: start)
        let endLocation = MKPlacemark(coordinate: finish)
        
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: endLocation)
        request.transportType = .automobile
        request.requestsAlternateRoutes = true
        
        let direction = MKDirections(request: request)
        direction.calculate { (response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response else {
                self.alertError(title: "Error", message: "Route is unavailable.")
                return
            }
            
            
            DispatchQueue.main.async {
                
                var minRoute = response.routes[0]
                for route in response.routes {
                    minRoute = (route.distance < minRoute.distance) ? route : minRoute
                }
                self.mapView.addOverlay(minRoute.polyline)
            }
        }
    }
    
    // MARK: Current place handling
    
    func showLocation(with place: Place) {
        
        let annotation = makeMapAnnotation(with: place)
        mapView.addAnnotation(annotation)
        
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(
            center: annotation.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        mapView.setRegion(coordinateRegion, animated: true)
        annotationsArray.append(annotation)
    }
    
    private func makeMapAnnotation(with place: Place) -> MKPointAnnotation {
        
        let coords = CLLocationCoordinate2D(
            latitude: place.latitude,
            longitude: place.longitude
        )
        let annotation = MKPointAnnotation()
        annotation.coordinate = coords
        annotation.title = place.name
        annotation.subtitle = place.subtitle
        
        return annotation
    }
    
    //MARK: - location delegate methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        self.currentPlace.latitude = userLocation.coordinate.latitude
        self.currentPlace.longitude = userLocation.coordinate.longitude
        self.currentPlace.name = "My current location"
        self.currentPlace.subtitle = "🤷🏼‍♀️"
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
        }

        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    
}


extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .purple
        return renderer
    }
}


// MARK: Set Up UI

extension ViewController {
    func setConstraints() {
        
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        mapView.addSubview(addAddressButton)
        NSLayoutConstraint.activate([
            addAddressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
            addAddressButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            addAddressButton.heightAnchor.constraint(equalToConstant: 100),
            addAddressButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        mapView.addSubview(locationButton)
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 130),
            locationButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            locationButton.heightAnchor.constraint(equalToConstant: 100),
            locationButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        mapView.addSubview(routeButton)
        NSLayoutConstraint.activate([
            routeButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            routeButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -70),
            routeButton.heightAnchor.constraint(equalToConstant: 100),
            routeButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        mapView.addSubview(resetButton)
        NSLayoutConstraint.activate([
            resetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            resetButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -70),
            resetButton.heightAnchor.constraint(equalToConstant: 100),
            resetButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
