//
//  GameDetailView.swift
//  WordScramble2
//
//  Created by Leon Grimmeisen on 18.06.22.
//

import SwiftUI

// add filter to list
// show found words firts

struct GameDetailView: View {
    let game: Game
    
    enum SortType {
        case alphabetical, correct
    }
    
    @State private var sortOrder = SortType.alphabetical
    @State private var isShowingSortOptions = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("Final score: \(game.score)")
                    Text("You got \(game.usedWords.count) out of \(game.possibleWords.count) possible words")
                }
                Section {
                    ForEach(sortedWords) { word in
                        HStack {
                            Text(word.word)
                            
                            Spacer()
                            
                            if game.usedWords.contains(word.word) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                } header: {
                    Text("Possible WORDS:")
                }
            }
        }
        .navigationTitle(game.rootWord)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowingSortOptions = true
                } label: {
                    Label("Sort", systemImage: "arrow.up.arrow.down")
                }
            }
        }
        .confirmationDialog("Sort by...",isPresented: $isShowingSortOptions) {
            Button("Alphabetical") { sortOrder = .alphabetical }
            Button("Corrects ones first") { sortOrder = .correct }
        }
    }
    
    var sortedWords: [PossibleWord] {
        let result = game.possibleWords
        
        if sortOrder == .alphabetical {
            return result.sorted { $0.word < $1.word }
        } else if sortOrder == .correct {
            return result.sorted { $0.word < $1.word }
        }
        
        return result
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(game: Game.example)
    }
}
