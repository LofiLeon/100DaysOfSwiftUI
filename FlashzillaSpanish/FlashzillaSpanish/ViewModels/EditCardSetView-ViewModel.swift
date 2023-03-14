//
//  EditCardSetView-ViewModel.swift
//  FlashzillaSpanish
//
//  Created by Leon Grimmeisen on 25.06.22.
//

import Foundation
import SwiftUI

extension EditCardSetView {
    @MainActor final class ViewModel: ObservableObject {
                
        @Published var cardSet: CardSet
        
        @Published var newPrompt = ""
        @Published var newPromptSentence = ""
        @Published var newAnswer = ""
        @Published var newAnswerSentence = ""
        
        init() {
            cardSet = CardSet.example
        }
        
        
        func addCardSet() {
        //    cardSets.cardSets.insert(cardSet, at: 0)
        }
        
        func addCard() {
            let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
            let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
            guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
            
            let card = Card(prompt: trimmedPrompt, promptSentence: newPromptSentence, answer: trimmedAnswer, answerSentence: newAnswerSentence)
            cardSet.cards.insert(card, at: 0)
            //        DataManager.save(cardSet)
            newPrompt = ""
            newPromptSentence = ""
            newAnswer = ""
            newAnswerSentence = ""
        }
        
//        func removeCards(at offsets: IndexSet) {
//            cardSet.cards.remove(atOffsets: offsets)
//            //        DataManager.save()
//        }
    }
}
