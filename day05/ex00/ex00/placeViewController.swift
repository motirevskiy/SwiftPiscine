//
//  placeViewController.swift
//  ex00
//
//  Created by Андрей Мотырев on 18.08.2022.
//

import Foundation
import UIKit

class placeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource   {
    
    var placesList = PlacesList().places
    
    @IBOutlet weak var placesTableList: UITableView!    {
        didSet  {
            placesTableList.delegate = self
            placesTableList.dataSource = self
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(placesList)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesListCell")
        cell?.textLabel?.text = placesList[indexPath.row].name
        return cell ?? UITableViewCell()
    }
    
    
}
