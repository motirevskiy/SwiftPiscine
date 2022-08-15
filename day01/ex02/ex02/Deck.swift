//
//  Deck.swift
//  ex02
//
//  Created by Андрей Мотырев on 11.08.2022.
//

import Foundation

class Deck : NSObject
{
    static let allSpades    : [Card] = Value.allValues.map({Card(c:Color.spades, v:$0)})
    static let allDiamonds    : [Card] = Value.allValues.map({Card(c:Color.diamonds, v:$0)})
    static let allHearts    : [Card] = Value.allValues.map({Card(c:Color.hearts, v:$0)})
    static let allClubs        : [Card] = Value.allValues.map({Card(c:Color.clubs, v:$0)})
    
    static let allCards        : [Card] = allSpades + allDiamonds + allHearts + allClubs
}
