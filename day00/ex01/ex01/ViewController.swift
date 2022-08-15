//
//  ViewController.swift
//  ex01
//
//  Created by Андрей Мотырев on 01.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clicked(_ sender: UIButton) {
        label.text = "Hello World"
    }
    
}

