//
//  ContentView.swift
//  Flashzilla
//
//  Created by Leon Grimmeisen on 06.06.22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = ContentViewViewModel()
    
    //In child views:
    //@ObservedObject  var vm: ContentViewViewModel

    var body: some View {
        NavigationView {
            
            List(vm.cardSets.cardSets) { cardSet in
                NavigationLink {
                    PlayView(cardSet: cardSet)
                        .environmentObject(vm)
                } label: {
                    VStack {
                        Text(cardSet.title)
                        Text("\(cardSet.cards.count) cards")
                    }
                }
            }
            
            .navigationTitle("Your card sets")
            .toolbar {
                Button {
                    vm.showingAddCardSetView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            
        }
        .sheet(isPresented: $vm.showingAddCardSetView) {
            AddCardSetView(cardSets: vm.cardSets)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
