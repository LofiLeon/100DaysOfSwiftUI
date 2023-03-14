////
////  EditCards.swift
////  Flashzilla
////
////  Created by Leon Grimmeisen on 08.06.22.
////
//
//import SwiftUI
//
//struct EditCards: View {
//    @Environment(\.dismiss) var dismiss
//    @State private var cards = DataManager.laod()
//    @State private var newPrompt = ""
//    @State private var newAnswer = ""
//
//    @State private var cardSet: CardSet
//
//    var body: some View {
//        NavigationView {
//            List {
//                Section("Add new card") {
//                    TextField("Prompt", text: $newPrompt)
//                    TextField("Answer", text: $newAnswer)
//                }
//
//                Section {
//                    ForEach(0..<cards.count, id: \.self) { index in
//                        VStack(alignment: .leading) {
//                            Text(cardSet.cards[index].prompt)
//                                .font(.headline)
//                            Text(cardSet.cards[index].answer)
//                                .foregroundColor(.secondary)
//                        }
//                    }
//                    .onDelete(perform: removeCards)
//                }
//            }
//            .navigationTitle("Edit Cards")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button("Return", action: done)
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Add card", action: addCard)
//                }
//            }
//            .listStyle(.grouped)
//        }
//    }
//
//    func done() {
//        dismiss()
//    }
//
//    func addCard() {
//        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
//        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
//        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
//
//        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
//        cardSet.cards.insert(card, at: 0)
//        DataManager.save(cards)
//        newPrompt = ""
//        newAnswer = ""
//    }
//
//    func removeCards(at offsets: IndexSet) {
//        cards.remove(atOffsets: offsets)
//        DataManager.save(cards)
//    }
//
//}
//
//struct EditCards_Previews: PreviewProvider {
//    static var previews: some View {
//        EditCards()
//    }
//}
