//
//  Card.swift
//  Destiny
//
//  Created by Vadym Dmytriiev on 1/25/18.
//  Copyright © 2018 Vadym Dmytriiev. All rights reserved.
//

import Foundation

class Card{
    
    var identifier: Int
    
    private static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
