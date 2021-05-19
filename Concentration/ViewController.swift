//
//  ViewController.swift
//  Concentration
//
//  Created by worker on 28/03/2019.
//  Copyright © 2019 Mike Volkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1) / 2
    }
    private var currentTheme: Theme!
    private var themes: [Theme]!
    
    private var emoji = [Card:String]()
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        self.currentTheme = chooseTheme()
        self.game.startNewGame()
        self.updateViewFromModel()
        print(currentTheme.images)
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = findIndex(in: cardButtons, of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        self.scoreLabel.text = "Flips: \(game.score)"
        self.view.backgroundColor = currentTheme.fontColor
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = currentTheme.colorOfFrontsideCard
                
            } else {
                button.setTitle(" ", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.5921568871, green: 0.8980392218, blue: 0.9176470637, alpha: 0) : currentTheme.colorOfBacksideCard
            }
        }
    }
    
    private func chooseTheme() -> Theme {
        let randomIndex = Int(arc4random_uniform(UInt32(self.themes.count)))
        return themes[randomIndex]
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, currentTheme.images.count > 0 {
            emoji[card] = currentTheme.images.remove(at: currentTheme.images.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
    
    private func findIndex(in array: [UIButton]!, of button: UIButton) -> Int? {
        for index in 0..<array.count {
            if array[index] == button {
                return index
            }
        }
        return nil
    }
    
    private func setUpThemes() {
        let hellowen = ["👻","🎃","🔪","🕷","😈","🦇","🍭","🍬","🍎","💀"]
        let sport = ["🏄🏿‍♀️","🚴🏽‍♀️","🏀","🏂","⛷","🎣","🏓","🏆","🏇🏾","🏸"]
        let smile = ["🤪","🧐","😛","😱","🙄","😍","😜","🤗","😴","😯"]
        _ = ["🍏","🧀","🍔","🌭","🍟","🍕","🍩","🍫","🌯","🍗"]
        _ = ["🇺🇸","🇨🇳","🇬🇧","🇷🇺","🇨🇦","🇯🇵","🇮🇹","🇧🇷","🇪🇺","🇩🇪"]
        
        let firstTheme = Theme(images: hellowen, colorOfFrontsideCard: #colorLiteral(red: 0.7960784435, green: 0.9490196109, blue: 0.7843137383, alpha: 1), colorOfBacksideCard: #colorLiteral(red: 0.9137254953, green: 0.6901960969, blue: 0.4980392158, alpha: 1), fontColor: #colorLiteral(red: 0.3960784376, green: 0.4313725531, blue: 0.9098039269, alpha: 1))
        let secondTheme = Theme(images: sport, colorOfFrontsideCard: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), colorOfBacksideCard: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), fontColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        let thirdTheme = Theme(images: smile, colorOfFrontsideCard: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), colorOfBacksideCard: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), fontColor: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1))
        
        self.themes = [firstTheme, secondTheme, thirdTheme]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpThemes()
        self.currentTheme = self.chooseTheme()
        
        let date = Date()
        let calendar = Calendar.current
        let seconds = calendar.component(.second, from: date)
        let deadTime = 3
        
        
        self.updateViewFromModel()
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
