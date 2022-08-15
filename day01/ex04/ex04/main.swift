//
//  main.swift
//  ex04
//
//  Created by Андрей Мотырев on 12.08.2022.
//

import Foundation

var testDeck = Deck(shuffleDeck: true)
var x: Card?

print(testDeck)

x = testDeck.draw()
x = testDeck.draw()
x = testDeck.draw()
x = testDeck.draw()
x = testDeck.draw()
x = testDeck.draw()
x = testDeck.draw()
x = testDeck.draw()
x = testDeck.draw()
x = testDeck.draw()

x = nil

print("")
for i in testDeck.outs {
        print("outs[i] = \(i)")
}
print("")
testDeck.fold(c: testDeck.outs[0])
testDeck.fold(c: testDeck.outs[1])
testDeck.fold(c: testDeck.outs[2])
testDeck.fold(c: testDeck.outs[3])

for i in testDeck.discards {
        print("discards[i] = \(i)")
}
print("")
for i in testDeck.outs {
        print("outs[i] = \(i)")
}
print("")
for i in testDeck.cards {
      print(i)
}

