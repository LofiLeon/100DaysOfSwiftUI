//
//  GamesHistory.swift
//  WordScramble2
//
//  Created by Leon Grimmeisen on 18.06.22.
//

import SwiftUI

struct GamesHistory: View {
    @StateObject var savedGames = SavedGames()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(savedGames.savedGames) { game in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(game.rootWord)
                            Text("Score: \(game.score)")
                                .font(.caption)
                        }
                        Spacer()
                        NavigationLink(destination: GameDetailView(game: game)) {
//                            Text("More")
                        }
                    }
                }
            }
        }
        .navigationTitle("All games")
        .environmentObject(savedGames)
    }
}

struct GamesHistory_Previews: PreviewProvider {
    static var previews: some View {
        GamesHistory()
    }
}
