//
//  placesMapViewController.swift
//  ex00
//
//  Created by Андрей Мотырев on 18.08.2022.
//

import Foundation
import MapKit

class placesMapViewController: UIViewController, MKMapViewDelegate  {
    @IBOutlet weak var placesMapView: MKMapView!    {
        didSet  {
            placesMapView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        placesMapView.isZoomEnabled = true
        placesMapView.addAnnotations(PlacesList.places)
        showPlace(place: PlacesList.places.last!)

    }

    func showPlace(place: MKAnnotation) {
        var region = MKCoordinateRegion()
        region.center = place.coordinate
        region.span.latitudeDelta = 0.01;
        region.span.longitudeDelta = 0.01;
        placesMapView.setRegion(region, animated: true)
    }
}
