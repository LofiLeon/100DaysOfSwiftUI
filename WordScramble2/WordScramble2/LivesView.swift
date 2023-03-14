//
//  LivesView.swift
//  WordScramble2
//
//  Created by Leon Grimmeisen on 17.06.22.
//

import SwiftUI

struct LivesView: View {
    @Binding var lives: Int
    
    var label = ""
    var maximumLives = 3
    
    var offImage: Image?
    var onImage = Image(systemName: "heart.fill")
    
    var offColor = Color.gray
    var onColor = Color.red
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumLives + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > lives ? offColor : onColor)
                    .onTapGesture {
                        lives = number
                    }
            }
        }
        
    }
    
    func image(for number: Int) -> Image {
        if number > lives {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct LivesView_Previews: PreviewProvider {
    static var previews: some View {
        LivesView(lives: .constant(4))
    }
}

