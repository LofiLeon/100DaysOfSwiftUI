//
//  DiceResult.swift
//  HighRollers
//
//  Created by Leon Grimmeisen on 13.06.22.
//

import Foundation

struct DiceResult: Identifiable, Codable {
    var id = UUID()
    var diceSides: Int
    var dicesAmount: Int
    var rolls = [Int]()
    
    init(diceSides: Int, dicesAmount: Int) {
        self.diceSides = diceSides
        self.dicesAmount = dicesAmount
        
        for _ in 0..<dicesAmount {
            let roll = Int.random(in: 1...diceSides)
            rolls.append(roll)
        }
    }
}
