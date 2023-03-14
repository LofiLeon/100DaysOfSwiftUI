//
//  Card.swift
//  FlashzillaSpanish
//
//  Created by Leon Grimmeisen on 25.06.22.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    var id  = UUID()
    
    var prompt: String
    var promptSentence: String
    var answer: String
    var answerSentence: String

    static let example = Card(prompt: "What", promptSentence: "Whats up?", answer: "Not", answerSentence: "Not much...")
}
