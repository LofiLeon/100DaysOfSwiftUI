//
//  EditCardSetView.swift
//  FlashzillaSpanish
//
//  Created by Leon Grimmeisen on 25.06.22.
//

import SwiftUI

struct EditCardSetView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = AddCardSetViewViewModel()
        
    @Binding var cardSets: [CardSet]
    @Binding var cardSet: CardSet
    
    var body: some View {
        NavigationView {
            List {
                TextField("Card set title", text: $cardSet.title)
                NavigationLink {
                    PlayView(cards: cardSet.cards)
                } label: {
                    Text("Play now!")
                }
                Section("Add new card") {
                    TextField("Prompt", text: $vm.newPrompt)
                    TextField("Prompt Sentence", text: $vm.newPromptSentence)
                    TextField("Answer", text: $vm.newAnswer)
                    TextField("Answer Sentence", text: $vm.newAnswerSentence)
                }
                
                Button("Add card") {
                    addCard()
                    print(cardSets)
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
            .navigationBarHidden(true)
//            .toolbar {
//                Button("Save") {
//                    dismiss()
//                    DataManager.save(cardSets)
//                }
//            }
        }
    }
    
    func addCard() {
        let trimmedPrompt = vm.newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = vm.newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, promptSentence: vm.newPromptSentence, answer: trimmedAnswer, answerSentence: vm.newAnswerSentence)
        cardSet.cards.insert(card, at: 0)
        vm.newPrompt = ""
        vm.newPromptSentence = ""
        vm.newAnswer = ""
        vm.newAnswerSentence = ""
    }
    
    func removeCard(at offsets: IndexSet) {
        cardSet.cards.remove(atOffsets: offsets)
    }
    
}

struct EditCardSetView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardSetView(cardSets: .constant([CardSet.example]), cardSet: .constant(CardSet.example))
    }
}
