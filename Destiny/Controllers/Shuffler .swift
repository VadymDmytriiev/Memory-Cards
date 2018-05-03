//
//  Shuffler .swift
//  Destiny
//
//  Created by Vadym Dmytriiev on 1/28/18.
//  Copyright © 2018 Vadym Dmytriiev. All rights reserved.
//

import Foundation
import UIKit


class Shuffler {
    
    var pictures: [UIImage] = [#imageLiteral(resourceName: "20"),#imageLiteral(resourceName: "12"),#imageLiteral(resourceName: "17"),#imageLiteral(resourceName: "23"),#imageLiteral(resourceName: "30"),#imageLiteral(resourceName: "13"),#imageLiteral(resourceName: "22"),#imageLiteral(resourceName: "19"),#imageLiteral(resourceName: "8"),#imageLiteral(resourceName: "6"),#imageLiteral(resourceName: "7"),#imageLiteral(resourceName: "27"),#imageLiteral(resourceName: "28"),#imageLiteral(resourceName: "25"),#imageLiteral(resourceName: "26"),#imageLiteral(resourceName: "24"),#imageLiteral(resourceName: "14"),#imageLiteral(resourceName: "29"),#imageLiteral(resourceName: "16"),#imageLiteral(resourceName: "18"),#imageLiteral(resourceName: "15"),#imageLiteral(resourceName: "33"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "11"),#imageLiteral(resourceName: "3"),#imageLiteral(resourceName: "4"),#imageLiteral(resourceName: "21"),#imageLiteral(resourceName: "10"),#imageLiteral(resourceName: "31")]
    
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    init(numberOfPairsOfCards: Int) {
        var unShuffledCards: [Card] = []
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            unShuffledCards += [card, card]
        }
        while !unShuffledCards.isEmpty {
            let randomIndex = Int(arc4random_uniform(UInt32(unShuffledCards.count)))
            let card = unShuffledCards.remove(at: randomIndex)
            cards.append(card)
        }
    }
    
    private var shuffledPics = [Int: UIImage]() 
    
    func pictureForCell(for card: Card) -> UIImage {
        if shuffledPics[card.identifier] == nil, pictures.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(pictures.count - 1)))
            shuffledPics[card.identifier] = pictures.remove(at: randomIndex)
        }
        return shuffledPics[card.identifier] ?? UIImage(named: "bbbb.png")!
    }
    
}


