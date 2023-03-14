//
//  ContentView.swift
//  Moonshot
//
//  Created by Leon Grimmeisen on 13.03.22.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("showingGrid") private var gridLayout = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            Group {
                if gridLayout {
                    GridView(astronauts: astronauts, missions: missions)
                    
                } else {
                    ListView(astronauts: astronauts, missions: missions)
                }
            }
            .toolbar {
                Button {
                    gridLayout.toggle()
                } label: {
                    if gridLayout {
                        Label("Show as Grid", systemImage: "list.dash")
                    } else {
                        Label("Show as List", systemImage: "square.grid.2x2")
                    }
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}
