//
//  ContentView.swift
//  AccessibilityTechnique
//
//  Created by Leon Grimmeisen on 27.05.22.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworkd"
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    @State private var value = 10
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Will be read by")
                    Text("VoiceOver")
                        .font(.title)
                }
                .accessibilityElement(children: .combine)
                
                Spacer()
                
                VStack {
                    Text("will not be read by")
                    Text("VoiceOver")
                        .font(.title)
                }
                .accessibilityElement(children: .ignore)
            }
            
            Spacer()
            Image(pictures[selectedPicture])
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    selectedPicture = Int.random(in: 0...3)
                }
                .accessibilityLabel(labels[selectedPicture])
                .accessibilityAddTraits(.isButton)
            
            Spacer()
            VStack {
                Text("Value: \(value)")
                Button("Increment") {
                    value += 1
                }
                Button("Decrement") {
                    value -= 1
                }
            }
            .accessibilityElement()
            .accessibilityLabel("Value")
            .accessibilityValue(String(value))
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment:
                    value += 1
                case .decrement:
                    value -= 1
                default:
                    print("Not handled")
                }
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
