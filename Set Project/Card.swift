//
//  Card.swift
//  Set Project
//
//  Created by Justin Biggs on 12/13/18.
//  Copyright © 2018 MindFrame. All rights reserved.
//

import Foundation
import UIKit

class Card: Equatable {
	static func == (lhs: Card, rhs: Card) -> Bool {
		if lhs.numberAppearing == rhs.numberAppearing || lhs.symbol.string.first == rhs.symbol.string.first
			|| lhs.color == rhs.color || lhs.pattern == rhs.pattern {
			return true
		} else {
			return false
		}
	}
	
	var isSelected = false
	var isMatched = false
	var identifier: Int
	var hasBeenIdentified = false
	static var identifierFactory = 0
	var numberAppearing: Int
	var symbol: NSAttributedString
	var color: UIColor
	var pattern: Double
	var cardSymbol: CardSymbols?
	var myAttributes: [NSAttributedString.Key: Any]

	static func getUniqueIdentifier() -> Int {
		identifierFactory += 1
		return identifierFactory
	}

	//Create a card with the four required parameters for a Set card
	init (symbol: String, color: UIColor, pattern: Double, numberAppearing: Int){
		 self.color = color
		self.pattern = pattern
		var repeatedString = ""
		if numberAppearing == 1 {repeatedString = symbol}
		if numberAppearing == 2 {repeatedString = symbol.doubleString}
		if numberAppearing == 3 {repeatedString = symbol.tripleString}
		self.identifier = Card.getUniqueIdentifier()
		myAttributes = [
			.strokeWidth: pattern,
			.strokeColor: color,
			]
		self.symbol = NSAttributedString(string: repeatedString, attributes: myAttributes)
		self.numberAppearing = numberAppearing
		if self.symbol.string.first == "▲" {
			self.cardSymbol = CardSymbols.triangle
		} else if self.symbol.string.first == "●" {
			self.cardSymbol = CardSymbols.circle
		} else if self.symbol.string.first == "■" {
			self.cardSymbol = CardSymbols.square
		}
		
		
	}
	
	//"▲","●","■"
}
