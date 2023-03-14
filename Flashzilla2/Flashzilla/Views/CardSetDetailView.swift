////
////  CardSetDetailView.swift
////  Flashzilla
////
////  Created by Leon Grimmeisen on 21.06.22.
////cxycyfdsaf
//
//import SwiftUI
//
//struct CardSetDetailView: View {
//
//    var cardSet: CardSet
//
////    @State private var cards = DataManager.laod()
//    @State private var newPrompt = ""
//    @State private var newAnswer = ""
//
//    var body: some View {
//        NavigationView {
////            TextField("Card set title", text: $cardSet.title)
//
//            List {
//                Section("Add new card") {
//                    TextField("Prompt", text: $newPrompt)
//                    TextField("Answer", text: $newAnswer)
//                }
//
//                Button("Add card") {
//                   addCard()
//                }
//
//                Section {
//                    ForEach(0..<cardSet.cards.count, id: \.self) { index in
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
//        }
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button("Add card set") {
//                   addCardSet()
//                }
//            }
//        }
//    }
//
//    func addCardSet() {
//        ///
//    }
//
//    mutating func addCard() {
//        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
//        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
//        guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
//
//        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
//        cardSet.cards.insert(card, at: 0)
////        DataManager.save(cardSet)
//        newPrompt = ""
//        newAnswer = ""
//    }
//
//    mutating func removeCards(at offsets: IndexSet) {
//        cardSet.cards.remove(atOffsets: offsets)
////        DataManager.save()
//    }
//}
//
////struct CardSetDetailView_Previews: PreviewProvider {
////    static var previews: some View {
////        CardSetDetailView()
////    }
////}
