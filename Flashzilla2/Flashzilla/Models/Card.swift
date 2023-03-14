//
//  Card.swift
//  Flashzilla
//
//  Created by Leon Grimmeisen on 06.06.22.
//

import Foundation

struct Card: Codable, Identifiable, Hashable {
    
    var id  = UUID()
    
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Whats up?", answer: "Not much...")
}
