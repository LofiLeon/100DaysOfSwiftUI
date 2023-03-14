//
//  AstronautDetails.swift
//  Moonshot
//
//  Created by Leon Grimmeisen on 14.03.22.
//

import SwiftUI

struct AstronautDetails: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle()
                                .strokeBorder(.white, lineWidth: 2)
                    )
                
                DividerView()
                
                Text(astronaut.description)
                    .padding()
                    .foregroundColor(.white)
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautDetails_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautDetails(astronaut: astronauts["armstrong"]!)
    }
}
