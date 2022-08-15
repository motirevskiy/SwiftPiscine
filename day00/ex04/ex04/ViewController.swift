//
//  ViewController.swift
//  ex03
//
//  Created by Андрей Мотырев on 08.08.2022.
//
var numberDouble: Double = 0
var numberPrevSign: Double = 0
var result: Double = 0
var flagEqual = false
var sign = ""
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Label: UILabel!
    @IBAction func digitsButton(_ sender: UIButton) {
        debugPrint("You pressed " + String(sender.tag) + " Button!")
        if (Label.text!.count <= 17)  {
            if (flagEqual)  {
                Label.text = ""
                numberDouble = 0
                flagEqual = false
            }
            Label.text = Label.text! + String(sender.tag)
            numberDouble = Double(Label.text!)!
        }
    }
    
    @IBAction func buttonSigns(_ sender: UIButton) {
        if (Label.text != "" && Label.text != "Error!" && Label.text != "Out of range")   {
            numberPrevSign = Double(Label.text!)!
            numberDouble = 0
            Label.text = ""

            if (sender.tag == 10)   {
                sign = "/"
            }
            else if (sender.tag == 11)   {
                sign = "x"
            }
            else if (sender.tag == 12)   {
                sign = "-"
            }
            else if (sender.tag == 13)   {
                sign = "+"
            }
        }
    }
    @IBAction func buttonEqual(_ sender: UIButton) {
        if (Label.text!.count != 0 || ((Label.text!.count != 0) && numberPrevSign != 0))   {
            if (sign == "/")    {
                if (numberDouble != 0)  {
                    result = numberPrevSign / numberDouble
                    Label.text = String(result)
                }
                else    {
                    Label.text = "Error!"
                    numberPrevSign = 0
                    numberDouble = 0
                    sign = ""
                }
            }
            else if (sign == "x")    {
                result = numberPrevSign * numberDouble
                if (result <= 1000000000000000000 && result >= -1000000000000000000)    {
                    Label.text = String(result)
                }
                else    {
                    Label.text = "Out of range"
                    numberPrevSign = 0
                }
            }
            else if (sign == "+")    {
                result = numberPrevSign + numberDouble
                if (result <= 1000000000000000000 && result >= -1000000000000000000)    {
                    Label.text = String(result)
                }
                else    {
                    Label.text = "Out of range"
                }
            }
            else if (sign == "-")    {
                result = numberPrevSign - numberDouble
                Label.text = String(result)
            }
            if (Label.text != "Error!" && result.truncatingRemainder(dividingBy: 1) == 0 && result <= 2147483647 && result >= -2147483647)  {
                Label.text = String(Int(result))
            }
            numberPrevSign = result
            result = 0
            //if (Label.text != "Error!") {
                flagEqual = true
            //}
        }
    }
    @IBAction func ACButton(_ sender: Any) {
        Label.text = ""
        numberDouble = 0
        numberPrevSign = 0
        sign = ""
        flagEqual = false
    }
    @IBAction func NegButton(_ sender: UIButton) {
        if (Label.text != ""  && Label.text != "Error!" && Label.text != "Out of range")   {
            numberDouble *= -1
            Label.text = String(numberDouble)
            if (numberDouble.truncatingRemainder(dividingBy: 1) == 0 && numberDouble <= 2147483647 && numberDouble >= -2147483647)  {
                Label.text = String(Int(numberDouble))
            }
            if (flagEqual)  {
                numberPrevSign *= -1
                Label.text = String(numberPrevSign)
                if (numberPrevSign.truncatingRemainder(dividingBy: 1) == 0 && numberPrevSign <= 2147483647 && numberPrevSign >= -2147483647)  {
                    Label.text = String(Int(numberPrevSign))
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
