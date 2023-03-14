//
//  CardSetsView.swift
//  FlashzillaSpanish
//
//  Created by Leon Grimmeisen on 25.06.22.
//

import SwiftUI

struct CardSetsView: View {
    
    @State private var cardSets: [CardSet] = DataManager.laod()
    @State private var showingAddCardSetView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(cardSets.indices, id: \.self) { index in
                    NavigationLink {
                        EditCardSetView(cardSets: $cardSets, cardSet: $cardSets[index])
                            
                    } label: {
                        VStack {
                            Text(cardSets[index].title)
                            Text("\(cardSets[index].cards.count) cards")
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Your card sets")
            .toolbar {
                Button {
                    showingAddCardSetView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
        }
        .sheet(isPresented: $showingAddCardSetView) {
            AddCardSetView(cardSets: $cardSets)
        }
    }
    
    func delete(at offsets: IndexSet) {
        cardSets.remove(atOffsets: offsets)
        DataManager.save(cardSets)
    }

}


struct CardSetsView_Previews: PreviewProvider {
    static var previews: some View {
        CardSetsView()
    }
}
