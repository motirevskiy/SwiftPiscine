//
//  ViewController.swift
//  ex03
//
//  Created by Андрей Мотырев on 14.08.2022.
//

import UIKit

class DetailedViewController: UIViewController, UIScrollViewDelegate {

	@IBOutlet weak var scrollView: UIScrollView!

	var detailedImageView: UIImageView!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		scrollView.addSubview(detailedImageView)
		scrollView.contentSize = detailedImageView.frame.size
    }

}
