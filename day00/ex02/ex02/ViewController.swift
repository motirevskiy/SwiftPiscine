//
//  ViewController.swift
//  ex02
//
//  Created by Андрей Мотырев on 01.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelLandsape: UILabel!
    @IBOutlet weak var line: UILabel!
    var prefOrientation = UIDevice.current.orientation
    override func viewDidLoad() {
        super.viewDidLoad()
        //Thread.sleep(forTimeInterval: 1)
        // Do any additional setup after loading the view.
    }
    @IBAction func digits(_ sender: UIButton) {
        line.text =  String(sender.tag)
        debugPrint("You pressed " + String(sender.tag) + " button")
    }
    @IBAction func digitsLandsape(_ sender: UIButton) {
        labelLandsape.text =  String(sender.tag)
        debugPrint("You pressed " + String(sender.tag) + " button")
    }
    func switchOrienatation(){
        performSegue(withIdentifier: "goVC", sender: nil)
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        switch UIDevice.current.orientation{
        case .portrait:
            dismiss(animated: true, completion: nil)
        case .portraitUpsideDown:
            dismiss(animated: true, completion: nil)
        case .landscapeLeft:
            if (prefOrientation != .landscapeRight && prefOrientation != .landscapeLeft)   {
                switchOrienatation()
            }
        case .landscapeRight:
            if (prefOrientation != .landscapeRight && prefOrientation != .landscapeLeft)   {
                switchOrienatation()
            }
        @unknown default:
            debugPrint("def")
        }
    }
}

