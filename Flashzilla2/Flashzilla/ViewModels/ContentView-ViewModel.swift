//
//  ContentView-ViewModel.swift
//  Flashzilla
//
//  Created by Leon Grimmeisen on 23.06.22.
//

import Foundation

final class ContentViewViewModel: ObservableObject {
    
    @Published var cardSets: CardSets
    @Published var showingAddCardSetView: Bool
    
    init() {
        // load data from storage
        self.cardSets = CardSets()
        self.showingAddCardSetView = false
    }
    
}

// cs 50x Harvard
// snippetsLab App

// dev cleaner
// Xcodes


