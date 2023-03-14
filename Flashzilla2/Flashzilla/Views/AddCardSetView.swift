//
//  AddCardSetView.swift
//  Flashzilla
//
//  Created by Leon Grimmeisen on 22.06.22.
//

import SwiftUI

struct AddCardSetView: View {
    @ObservedObject var cardSets: CardSets
    @Environment(\.dismiss) var dismiss

    @State var newCardSet = CardSet(id: UUID(), cards: [], title: "")
    
    // @State private var cards = DataManager.laod()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
        
    var body: some View {
        NavigationView {
//            TextField("Card set title", text: $cardSet.title)
            
            List {
                TextField("Card set title", text: $newCardSet.title)
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                }
                
                Button("Add card") {
                   addCard()
                }
                
                Section {
                    ForEach(0..<newCardSet.cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(newCardSet.cards[index].prompt)
                                .font(.headline)
                            Text(newCardSet.cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
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
        cardSets.cardSets.insert(newCardSet, at: 0)
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        newCardSet.cards.insert(card, at: 0)
//        DataManager.save(cardSet)
        newPrompt = ""
        newAnswer = ""
    }
    
    func removeCards(at offsets: IndexSet) {
        newCardSet.cards.remove(atOffsets: offsets)
//        DataManager.save()
    }
}

struct AddCardSetView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardSetView(cardSets: CardSets())
    }
}
