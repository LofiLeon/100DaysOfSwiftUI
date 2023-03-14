//
//  ContentView.swift
//  WordScramble2
//
//  Created by Leon Grimmeisen on 17.06.22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var showingGameOver = false

    @State private var wordsCount = 0
    @State private var charactersCount = 0
    
    @State private var remainingLives = 3
    @AppStorage("highscore") private var highscore = 0
    
//    @State private var savedGames = Games.savedGames

    @StateObject var savedGames = SavedGames()

    @FocusState private var newWordFocused: Bool

    var body: some View {
        NavigationView {
            List {
                HStack {
                    Spacer()

                    Text("\(wordsCount * charactersCount)")
                        .font(.title)
                    
                    Spacer()
                    VStack {
                        LivesView(lives: .constant(remainingLives))
                            .padding(5)
                        Text("Highscore: \(highscore)")
                    }
                }
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                        .focused($newWordFocused)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                } header: {
                    Text("WORDS: \(wordsCount) | LETTERS: \(charactersCount)")
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
//            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .alert("Game Over", isPresented: $showingGameOver) {
                Button("Don't save") {
                    startGame()
                }
                Button("Save game") {
                    storeGame()
                    startGame()
                }
            } message: {
                Text("You lost all your lives...")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: GamesHistory()) {
                        Text("History")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("New game") {
                        startGame()
                    }
                    
                }
            }
        }
        .environmentObject(SavedGames())
    }
    
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

        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        charactersCount += answer.count
        wordsCount += 1
        
        newWord = ""
        newWordFocused = true
        }
    
    func gameOver() {
        if remainingLives == 1 {
            showingGameOver = true
            if wordsCount * charactersCount >= highscore {
                highscore = wordsCount * charactersCount
            }
        }
    }

    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                
                if wordsCount * charactersCount >= highscore {
                    highscore = wordsCount * charactersCount
                }
                
                remainingLives = 3
                newWord = ""
                usedWords = []
                wordsCount = 0
                charactersCount = 0
                
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
        
        newWord = ""
        newWordFocused = true
    }
    
    func storeGame() {
        if !rootWord.isEmpty {
        let game = Game(id: UUID(), rootWord: rootWord, usedWords: usedWords, wordsCount: wordsCount, charactersCount: charactersCount, remainingLives: remainingLives, score: wordsCount * charactersCount)
            savedGames.add(game)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
