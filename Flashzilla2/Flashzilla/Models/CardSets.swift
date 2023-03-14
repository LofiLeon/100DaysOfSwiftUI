//
//  CardSets.swift
//  Flashzilla
//
//  Created by Leon Grimmeisen on 22.06.22.
//

import Foundation

class CardSets: ObservableObject {
    
    @Published var cardSets = [CardSet]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(cardSets) {
                UserDefaults.standard.set(encoded, forKey: "CardSets")
            }
        }
    }
    
    init() {
        if let savedSets = UserDefaults.standard.data(forKey: "CardSets") {
            if let decodedSets = try? JSONDecoder().decode([CardSet].self, from: savedSets) {
                cardSets = decodedSets
                return
            }
        }
        
        cardSets = []
    }
}
