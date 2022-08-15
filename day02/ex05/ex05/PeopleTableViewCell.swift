//
//  ViewController.swift
//  ex00
//
//  Created by Андрей Мотырев on 01.08.2022.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var people: (String, String, String)? {
        didSet {
            if let p = people {
                nameLabel?.text = p.0
                descriptionLabel?.text = p.1
                dateLabel?.text = p.2
            }
        }
    }

}
