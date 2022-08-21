//
//  placesMapViewController.swift
//  day06
//
//  Created by Андрей Мотырев on 20.08.2022.
//

import Foundation
import UIKit

class Form: UIView {
    var type: String = "Rectangle"
    var collisionType: UIDynamicItemCollisionBoundsType = .rectangle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        if (arc4random_uniform(2) == 0) {
            type = "Circle"
        }
        switch(arc4random_uniform(4)) {
        case 0:
            backgroundColor = UIColor.lightGray
        case 1:
            backgroundColor = UIColor.green
        case 2:
            backgroundColor = UIColor.blue
        case 3:
            backgroundColor = UIColor.yellow
        default:
            backgroundColor = UIColor.black
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return collisionType
    }
    
    override var bounds: CGRect {
        get { return super.bounds }
        set(newBounds) {
            super.bounds = newBounds
            if (self.type == "Circle") {
                layer.cornerRadius = newBounds.size.width / 2.0
                self.collisionType = .ellipse
            }
        }
    }
    
}
