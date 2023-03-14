//
//  DataManager.swift
//  FlashzillaSpanish
//
//  Created by Leon Grimmeisen on 26.06.22.
//

import Foundation

struct DataManager {
    static let savePath = FileManager.documentsDirectory.appendingPathComponent("SaveData")

    static func laod() -> [CardSet] {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([CardSet].self, from: data) {
                return decoded
            }
        }
        return []
    }

    static func save(_ cardSets: [CardSet]) {
        if let data = try? JSONEncoder().encode(cardSets) {
            try? data.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
}
