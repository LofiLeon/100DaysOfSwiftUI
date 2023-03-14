//
//  ContentView.swift
//  Instafilter
//
//  Created by Leon Grimmeisen on 11.04.22.
//

import SwiftUI

struct ContentView: View {
    var images : [String] = ["1", "2", "3", "4", "5"]
    @State private var randomPicture: String = "1"
    @State private var blurAmount = 0.0
    @State private var frameColor = Color.blue
    @State private var showingConfirmation = false
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    var body: some View {
        
        VStack {
            Text("Edifilter")
                .font(.title)
            
            Image(randomPicture)
                .resizable()
                .blur(radius: blurAmount)
                .scaledToFit()
                .padding(30)
                .background(frameColor)
            Spacer()

            Group {
                Button("Random Picture") {
                    randomPicture = chooseRandomImage()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                Spacer()
                
                Button("Change Frame") {
                    showingConfirmation = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                Spacer()
                Text("Change blur:")
                Slider(value: $blurAmount, in: 0...20)
                    .padding()
                Spacer()
            }
            
            Button("Add Pictures") {
                showingImagePicker = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .confirmationDialog("Change frame", isPresented: $showingConfirmation) {
            Button("Blue") { frameColor = .blue }
            Button("Red") { frameColor = .red }
            Button("Green") { frameColor = .green }
            Button("Black") { frameColor = .black }
            Button("Cancel", role: .cancel) { }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker()
        }
    }
    
    func chooseRandomImage() -> String {
        let array = images
        let result = array.randomElement()!
        return result
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
