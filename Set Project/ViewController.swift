//
//  ViewController.swift
//  Set Project
//
//  Created by Justin Biggs on 12/13/18.
//  Copyright © 2018 MindFrame. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
	
	lazy var game = SetGame()
	var count = 0
	var selectedCards = [Card]()
	var cardsForEachButton = [Card]()
	@IBOutlet var cardButtons: [UIButton]!
	override func viewDidLoad() {
		loadCards()
	}
	var pointCount = 0 {
		didSet {
			pointLabel.text = "Points: \(pointCount)"
		}
		
	}
	
	@IBOutlet weak var pointLabel: UILabel!
	@IBAction func DealThreeMore(_ sender: UIButton) {
			//add three more to the card set.  Be careful not to add more cards than there are buttons.
		addThreeCards()
	
	}
	
	
	@IBAction func touchCard(_ sender: UIButton) {
		
		if let cardIndex = cardButtons.index(of: sender) {
			let card = cardsForEachButton[cardIndex]
			cardButtons[cardIndex].layer.borderWidth = 3.0
			cardButtons[cardIndex].layer.borderColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
			selectedCards.append(card)
		}
		
		//Closure function inserted as part of the assignment.
		var increment: (Int) -> Int
		increment = {$0 + 1}
		count = increment(count)
		if count > 2 {
			game.chooseCardSet(cards: selectedCards)
			for each in cardButtons.indices {
				cardButtons[each].layer.borderWidth = 0
			}
			pointCount = game.points
			selectedCards = [Card]()
			updateViewFromModel()
			count = 0
		}
		
		
	}
	func updateViewFromModel () {
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card = cardsForEachButton[index]
			if card.isMatched {
				button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
				button.setAttributedTitle(nil, for: .normal)
			} else {
				button.setAttributedTitle(card.symbol, for: .normal)
				button.backgroundColor = #colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1)
			}
	
		}
	}
	@IBAction func newGame(_ sender: UIButton) {
		cardsForEachButton = [Card]()
		self.game = SetGame()
		loadCards()
		//updateViewFromModel()
		pointCount = 0
	}
	func loadCards () {
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card = game.getNewCard()
			cardsForEachButton.append(card)
				button.setAttributedTitle(card.symbol, for: UIControl.State.normal)
				button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
		}
	}
	//changes to hidden any matched cards.

	func addThreeCards () {
		let hiddenCardButtons : [Int] = cardButtons.indices.filter { cardButtons[$0].attributedTitle(for: .normal) == nil }
		if hiddenCardButtons.count > 0 {
		print(hiddenCardButtons)
		for index in 0..<3 {
			//grab a new card from the game card heap.  Add it to the view's deck.
			cardsForEachButton[hiddenCardButtons[index]] = game.getNewCard()
			let button = cardButtons[hiddenCardButtons[index]]
			button.setAttributedTitle(cardsForEachButton[hiddenCardButtons[index]].symbol, for: UIControl.State.normal)
			button.backgroundColor = #colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1)
			
		}
		}
	}
}




