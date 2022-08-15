//
//  main.swift
//  ex01
//
//  Created by Андрей Мотырев on 11.08.2022.
//

import Foundation

let card1 : Card = Card(c: Color.hearts, v: Value.king)
let card2 : Card = Card(c: Color.diamonds, v: Value.queen)
let card3 : Card = Card(c: Color.clubs, v: Value.ace)
let card4 : Card = Card(c: Color.hearts, v: Value.king)

print("Our cards:")
print("card 1 is \(card1)")
print("card 2 is \(card2)")
print("card 3 is \(card3)")
print("card 4 is \(card4)")

print("")

print("Tests for override function:")
print("Check if card 1 is equal to card 2")
print(card1.isEqual(card2))
print("Check if card 1 is equal to card 3")
print(card1.isEqual(card3))
print("Check if card 1 is equal to card 4")
print(card1.isEqual(card4))

print("")

print("Tests for overloaded operator:")
print("Check if card 1 is equal to card 2")
print(card1 == card2)
print("Check if card 1 is equal to card 3")
print(card1 == card3)
print("Check if card 1 is equal to card 4")
print(card1 == card4)
