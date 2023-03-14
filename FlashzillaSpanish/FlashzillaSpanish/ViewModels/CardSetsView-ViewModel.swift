//
//  CardSetsView-ViewModel.swift
//  FlashzillaSpanish
//
//  Created by Leon Grimmeisen on 25.06.22.
//

import Foundation

extension CardSetsView {
    @MainActor final class ViewModel: ObservableObject {
        
        @Published var cardSets = [CardSet]()
        @Published var showingAddCardSetView = false
        
        init() {
            // load data from storage
        }
    }
}
