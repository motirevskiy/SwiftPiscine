//
//  ViewController.swift
//  day07
//
//  Created by Андрей Мотырев on 21.08.2022.
//

import UIKit
import RecastAI
import ForecastIO
import CoreLocation

class ViewController: UIViewController {

    var place: String?
    var date: Date?
    var temperature: String?
    var recast: RecastAIClient?
    var darkSky: DarkSkyClient?
    var locationCoordinates: CLLocationCoordinate2D? {
        didSet  {
            getForcastFromDarkSky()
        }
    }
    var forcastText: String = "Enter city" {
        didSet {
            DispatchQueue.main.async {
                self.PlaceLabel.text = "At " + self.place! + " is"
                self.tempLabel.text = self.temperature! + "°C"
                self.answerLabel.text = self.forcastText
                self.revelatDate.text = "revelant for " + self.dateOutlet.date.formatted()
            }
        }
    }
    
    @IBOutlet weak var revelantDate: UILabel!
    @IBOutlet weak var revelatDate: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var PlaceLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var dateOutlet: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerLabel.text = forcastText
        self.recast = RecastAIClient(token : "c80f802ac6dd241654df237385b351b5", language: "en")
        self.darkSky = DarkSkyClient(apiKey: "2ac4b9753bab9108db8df8f8a3705537")
        darkSky?.units = .si
        darkSky?.language = .english
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        if textField.text != nil   {
            make(request: textField.text!)
            date = dateOutlet.date
        }
        self.view.endEditing(true)
    }

    func make(request: String)  {
        recast?.textRequest(request, successHandler: { (response) in
            if let locations = response.all(entity: "location") {
                let coordinates = (locations[0]["formatted"] as? String, locations[0]["lat"]?.doubleValue, locations[0]["lng"]?.doubleValue)
                if (coordinates.0 == nil || coordinates.1 == nil || coordinates.2 == nil)   {
                    self.answerLabel.text = "error request"
                }
                else    {
                    //self.answerLabel.text = "\(coordinates.0!)\nLAT: \(coordinates.1!)\nLNG: \(coordinates.2!)"
                    self.locationCoordinates = CLLocationCoordinate2D(
                        latitude: coordinates.1!,
                        longitude: coordinates.2!
                    )
                    self.place = coordinates.0!
                }
            } else {
                self.answerLabel.text = "Enter a valid City!"
            }
        }, failureHandle: { (error) in
            self.answerLabel.text = "Error"
        })
    }
    
    func getForcastFromDarkSky() {
        if locationCoordinates != nil {
            darkSky?.getForecast(location: locationCoordinates!, time: date!, completion: { result in
                switch result {
                    case .success((let currentForecast, _)):
                        self.forcastText = currentForecast.currently?.summary?.description ?? "Oups..."
                        self.temperature = String(currentForecast.currently!.temperature!)
                    case .failure:
                        self.forcastText = "ERROR"
                }
            })
        }
    }
}
