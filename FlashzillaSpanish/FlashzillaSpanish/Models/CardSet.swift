//
//  CardSet.swift
//  FlashzillaSpanish
//
//  Created by Leon Grimmeisen on 25.06.22.
//

import Foundation

struct CardSet: Identifiable, Codable, Equatable {
    var id = UUID()
    var cards: [Card] = []
    var title: String = ""
    
    static let example = CardSet(cards: [Card.example] , title: "Example Set")
    static let emptyCardSet = CardSet(cards: [], title: "")
}
