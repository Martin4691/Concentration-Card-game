//
//  ViewController.swift
//  Concentration Card Game
//
//  Created by Martín on 16/3/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    private lazy var game: Concentration = Concentration(numberOfPairsCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1) / 2
    }
    
    
    private(set) var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flip: \(flipCount)"
        }
    }
    
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
            print("Card Number: \(cardNumber)")
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
        
    }
    
    private var flagsChoices: [String] = ["🇨🇭", "🇺🇸", "🇪🇸", "🇳🇱", "🇮🇪", "🇩🇰", "🇮🇸", "🇳🇴", "🇸🇪"]
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, flagsChoices.count > 0 {
            emoji[card] = flagsChoices.remove(at: flagsChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
        
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}



