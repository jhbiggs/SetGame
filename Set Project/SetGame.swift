//
//  SetGame.swift
//  Set Project
//
//  Created by Justin Biggs on 12/13/18.
//  Copyright © 2018 MindFrame. All rights reserved.
//

import Foundation
import UIKit

class SetGame
{
	let numberOfPermutations = 3
	var cards = [Card]()
	var cardSelection: Card?
	var points = 0
	var matchedCards: [Int] {
		get {
			return cards.indices.filter {cards[$0].isMatched}
		}
		
	}
	let cardCharacters = ["▲","●","■"]
	let patterns = [-6.0, 2.0, 6.0]
	let colors = [UIColor.blue, UIColor.yellow, UIColor.red]
	let numberAppearing = [1,2,3]
	var selectedCards: [Int?]

	init() {
		for number in 0..<numberAppearing.count{
			for color in 0..<colors.count {
				for pattern in 0..<patterns.count {
					for char in 0..<cardCharacters.count {
						cards.append(Card(symbol: cardCharacters[char], color: colors[color], pattern: patterns[pattern], numberAppearing: numberAppearing[number]))
						}
					}
				}
			}
		self.selectedCards = [nil]
	
		cards.shuffle()
		
	}
	
	func getNewCard() -> Card {
		return cards.removeFirst()
	}
	
	func chooseCardSet (cards:[Card]) {
		var cardMatch = 0
		var atLeastOneCardMatched = false {
			didSet {
				points += 3
			}
		}
		let compare: (Card,Card,Card) -> Bool
		compare = {if $0.color == $1.color && $1.color == $2.color{ $0.isMatched = true; $1.isMatched = true; $2.isMatched = true; print("Colors are equal")
			return true
			}
			return false}
	
		
		if (compare(cards[0], cards[1], cards[2])) {
			cardMatch += 1
		}
		if cards[0].symbol.string.first == cards[1].symbol.string.first {
			if cards[1].symbol.string.first == cards[2].symbol.string.first {
				print("symbols are equal")
				for card in cards {
					card.isMatched = true
					cardMatch += 1
				}
			}
		}
		if cards[0].numberAppearing == cards[1].numberAppearing {
			if cards[1].numberAppearing == cards[2].numberAppearing {
				print("numbers appearing are equal")
				for card in cards {
					card.isMatched = true
					cardMatch += 1
				}
			}
		}
		if cards[0].pattern == cards[1].pattern {
			if cards[1].pattern == cards[2].pattern {
				print("stroke widths are equal")
				for card in cards {
					card.isMatched = true
					cardMatch += 1
				}
			}
		}
		if cardMatch > 0 {
			atLeastOneCardMatched = true
		}
		//attempting a git add here...
		
	}

	
}

enum CardSymbols {
	case triangle, circle, square

}

extension String {
	var doubleString: String {return self+self}
	var tripleString: String {return self+self+self}
}


