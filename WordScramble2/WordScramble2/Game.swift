//
//  Game.swift
//  WordScramble2
//
//  Created by Leon Grimmeisen on 18.06.22.
//

import Foundation

struct Game: Identifiable, Codable {
    var id: UUID
    var rootWord: String
    
    var usedWords: [String]
    var wordsCount: Int
    var charactersCount: Int
    
    var remainingLives: Int
    var score: Int
    
    var possibleWords: [PossibleWord] {
        getAllWords(word: rootWord)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func getAllWords(word: String) -> [PossibleWord] {
        var result = [PossibleWord]()
        //get start file
        if let allWordsURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let allWords = try? String(contentsOf: allWordsURL) {
                var allWords = allWords.components(separatedBy: "\n")
                allWords.remove(at: allWords.count - 1)
                
                for word in allWords {
                    if isPossible(word: word) {
                        let newWord = PossibleWord(id: UUID(), word: word)
                        result.insert(newWord, at: 0)
                        print("I am here")
                    }
                }
                return result
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    
    static let example = Game(id: UUID(), rootWord: "rootword", usedWords: ["root", "word"], wordsCount: 2, charactersCount: 8, remainingLives: 4, score: 32)
}

@MainActor class SavedGames: ObservableObject {
    
    @Published var savedGames: [Game]
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")
    
    init() {
        //loading the existing games from Directory
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Game].self, from: data) {
                savedGames = decoded
                return
            }
            savedGames = [Game]()
        }
        // if no data was loaded:
        savedGames = [Game]()
    }
    
    // saving the prospects to user defaults
    // This method needs to be called every time our data changes
    private func save() {
        if let encoded = try? JSONEncoder().encode(savedGames) {
            try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
    
    func add(_ game: Game) {
        savedGames.append(game)
        save()
    }
    
}
