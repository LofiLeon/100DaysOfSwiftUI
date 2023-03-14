//
//  ContentView-ViewModel.swift
//  WordScramble2
//
//  Created by Leon Grimmeisen on 18.06.22.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var usedWords = [String]()
        @Published var rootWord = ""
        @Published var newWord = ""

        @Published var errorTitle = ""
        @Published var errorMessage = ""
        @Published var showingError = false
        @Published var showingGameOver = false

        @Published var wordsCount = 0
        @Published var charactersCount = 0
        
        @Published var remainingLives = 4
        @Published var highscore = 0

        func addNewWord() {
            gameOver()
            
            let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            guard answer.count > 0 else { return }

            guard isOriginal(word: answer) else {
                wordError(title: "Word used already", message: "Be more original!")
                return
            }

            guard isPossible(word: answer) else {
                wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
                return
            }

            guard isReal(word: answer) else {
                wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
                return
            }

            
            charactersCount += answer.count
            wordsCount += 1
            
            newWord = ""
            }
        
        func gameOver() {
            if remainingLives == 0 {
                showingGameOver = true
            }
        }

        func startGame() {
            if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
                if let startWords = try? String(contentsOf: startWordsURL) {
                    let allWords = startWords.components(separatedBy: "\n")
                    rootWord = allWords.randomElement() ?? "silkworm"
                    
                    remainingLives = 5
                    newWord = ""
                    
                    return
                }
            }

            fatalError("Could not load start.txt from bundle.")
        }

        func isOriginal(word: String) -> Bool {
            !usedWords.contains(word)
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

        func isReal(word: String) -> Bool {
            let checker = UITextChecker()
            let range = NSRange(location: 0, length: word.utf16.count)
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

            return misspelledRange.location == NSNotFound
        }

        func wordError(title: String, message: String) {
            errorTitle = title
            errorMessage = message
            showingError = true
            remainingLives -= 1
        }
    }
}
