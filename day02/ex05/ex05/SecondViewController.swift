//
//  ViewController.swift
//  ex00
//
//  Created by Андрей Мотырев on 01.08.2022.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var nameAddTextField: UITextField!
    
    @IBOutlet weak var dateAddDatePicker: UIDatePicker!
    
    @IBOutlet weak var descriptionAddTextView: UITextView!
    
    @IBAction func doneButton(_ sender: UIButton) {
        if let name = nameAddTextField.text {
            print(name)
        }
        if let description = descriptionAddTextView.text {
            print(description)
        }
        let format = DateFormatter()
        format.dateFormat = "dd MMMM yyyy HH:mm:ss"
        let date = format.string(from: dateAddDatePicker.date)
        print(date)
        if nameAddTextField.text != "" {
            performSegue(withIdentifier: "toFirstView", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let format = DateFormatter()
        format.dateFormat = "dd MMMM yyyy HH:mm:ss"
        let date = format.string(from: dateAddDatePicker.date)
        Data.people.append((nameAddTextField.text!, descriptionAddTextView.text!, date))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateAddDatePicker.minimumDate = Date(timeIntervalSinceNow: 0)
        nameAddTextField.placeholder = "Name"
        // Do any additional setup after loading the view.
    }
}
