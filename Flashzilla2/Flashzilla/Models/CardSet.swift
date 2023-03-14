//
//  CardSet.swift
//  Flashzilla
//
//  Created by Leon Grimmeisen on 21.06.22.
//

import Foundation

struct CardSet: Identifiable, Codable {
    var id : UUID
    var cards: [Card]
    var title: String
    
    static let example = CardSet(id: UUID(), cards: [Card(prompt: "Whats up?", answer: "Not much..."), Card(prompt: "Whats down!", answer: "A lot!")] , title: "Example Set")
    
}
