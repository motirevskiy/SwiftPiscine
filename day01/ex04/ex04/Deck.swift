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
    
    var cards = allCards
    var discards = [Card]()
    var outs = [Card]()
    
    init (shuffleDeck: Bool) {
        if (shuffleDeck)    {
            cards.shuffle()
        }
    }
    
    override var description: String    {
        return (self.cards.description)
    }
    
    func draw() -> Card?    {
        var drawCard: Card?
        if (cards.count > 0)    {
            drawCard = cards.removeFirst()
            outs.append(drawCard!)
        }
        return (drawCard)
    }
    
    func fold(c : Card) {
        var index = 0
        for elem in self.outs   {
            if elem == c  {
                self.discards.append(elem)
                self.outs.remove(at: index)
            }
            index += 1
        }
    }
}


extension Array {
    mutating func shuffle() {
        var index = 0
        for i in  0..<self.count {
            index = Int(arc4random_uniform(UInt32(self.count)))
            if i != index {
                    self.swapAt(i, index)
            }
        }
    }
}
