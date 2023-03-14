//
//  AddCardSetView.swift
//  FlashzillaSpanish
//
//  Created by Leon Grimmeisen on 25.06.22.
//

import SwiftUI

struct AddCardSetView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var vm = AddCardSetViewViewModel()
        
    @Binding var cardSets: [CardSet]
    @State private var cardSet = CardSet()
    
    var body: some View {
        NavigationView {
            
            List {
                TextField("Card set title", text: $cardSet.title)
                Section("Add new card") {
                    TextField("Prompt", text: $vm.newPrompt)
                    TextField("Prompt Sentence", text: $vm.newPromptSentence)
                    TextField("Answer", text: $vm.newAnswer)
                    TextField("Answer Sentence", text: $vm.newAnswerSentence)
                }
                
                Button("Add card") {
                    addCard()
                }
                
                Section {
                    ForEach(0..<cardSet.cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cardSet.cards[index].prompt)
                                .font(.headline)
                            Text(cardSet.cards[index].answer)
                                .foregroundColor(.secondary)
                            Text(cardSet.cards[index].promptSentence)
                                .font(.headline)
                            Text(cardSet.cards[index].answerSentence)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCard)
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                Button("Save") {
                    addCardSet()
                    dismiss()
                }
            }
        }
    }
    
    func addCardSet() {
        cardSets.insert(cardSet, at: 0)
        DataManager.save(cardSets)
    }
    
    func addCard() {
        let trimmedPrompt = vm.newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = vm.newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, promptSentence: vm.newPromptSentence, answer: trimmedAnswer, answerSentence: vm.newAnswerSentence)
        cardSet.cards.insert(card, at: 0)
        //        DataManager.save(cardSet)
        vm.newPrompt = ""
        vm.newPromptSentence = ""
        vm.newAnswer = ""
        vm.newAnswerSentence = ""
        DataManager.save(cardSets)
    }
    
    func removeCard(at offsets: IndexSet) {
        cardSet.cards.remove(atOffsets: offsets)
        DataManager.save(cardSets)
    }
}

struct AddCardSetView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardSetView(cardSets: .constant([CardSet.example]))
    }
}
