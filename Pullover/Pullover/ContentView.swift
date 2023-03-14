//
//  ContentView.swift
//  Pullover
//
//  Created by Leon Grimmeisen on 07.03.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var scale = 1.0
    @State private var scale2 = 1.0

    
    var body: some View {
        VStack{
            VStack{
                Spacer()
                Spacer()
            }

            HStack{
                Text("I")
                //stay
                    .font(.largeTitle)
                    .foregroundColor(enabled ? .red : .white)
                    .offset()
                    .scaleEffect(scale)
                    .animation(.interpolatingSpring(stiffness: 10, damping: 1))
                
                Text("think your")
                //move
                    .font(.largeTitle)
                    .foregroundColor(enabled ? .gray : .white)
                    .offset(dragAmount)
                    .animation(.default, value: dragAmount)
            }
            Spacer()
            HStack(spacing:0){
                Text("pul")
                    .font(.largeTitle)
                    .foregroundColor(enabled ? .gray : .white)
                    .offset(dragAmount)
                    .animation(.default, value: dragAmount)
                Text("love")
                    .font(.largeTitle)
                    .foregroundColor(enabled ? .red : .white)
                    .offset()
                    .scaleEffect(scale)
                    .animation(.interpolatingSpring(stiffness: 10, damping: 1))
                Text("r")
                    .font(.largeTitle)
                    .foregroundColor(enabled ? .gray : .white)
                    .offset(dragAmount)
                    .animation(.default, value: dragAmount)
            }
            Spacer()
            HStack{
                Text("really suits")
                    .font(.largeTitle)
                    .foregroundColor(enabled ? .gray : .white)
                    .offset(dragAmount)
                    .animation(.default, value: dragAmount)

                Text("you")
                    .font(.largeTitle)
                    .foregroundColor(enabled ? .red : .white)
                    .offset()
                    .scaleEffect(scale)
                    .animation(.interpolatingSpring(stiffness: 10, damping: 1))
            }
            Spacer()
            Text("knuknu!")
                .font(.largeTitle)
                .foregroundColor(enabled ? .red : .black)
                .offset()
                .scaleEffect(scale)
                .animation(.interpolatingSpring(stiffness: 10, damping: 1))
            VStack{
                Spacer()
                Spacer()
            }
        }
        .font(.title)
        .gesture(
            DragGesture()
                .onChanged {
                    dragAmount = $0.translation
                    enabled = true
                    scale = 2
                    scale2 = 0.5
                }
                .onEnded { _ in
                    dragAmount = .zero
                    enabled = false
                    scale = 1
                    scale2 = 1
                }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
