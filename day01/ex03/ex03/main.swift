//
//  main.swift
//  ex03
//
//  Created by Андрей Мотырев on 11.08.2022.
//

import Foundation

var testCards = Deck.allCards

testCards.shuffle()

print("Shuffled card deck:")
print("")
for elem in testCards {
    print(elem)
}
