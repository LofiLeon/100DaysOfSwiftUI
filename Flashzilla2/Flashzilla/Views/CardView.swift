//
//  CardView.swift
//  Flashzilla
//
//  Created by Leon Grimmeisen on 06.06.22.
//

import SwiftUI

extension Shape {
    func fill(using offset: CGSize) -> some View {
        if offset.width == 0 {
            return self.fill(.white)
        } else if offset.width > 0 {
            return self.fill(.green)
        } else {
            return self.fill(.red)
        }
    }
}

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @StateObject private var vm = CardViewViewModel()

    let card: Card

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(vm.offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(using: vm.offset)
                )
                .shadow(radius: 10)
            VStack {
                if voiceOverEnabled {
                    Text(vm.isShowingAnswer ? card.answer : card.prompt)
                        .font(.title)
                        .foregroundColor(.black)
                } else {
                    Text($vm.card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    if vm.isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(vm.offset.width / 5)))
        .offset(x: vm.offset.width * 5, y: 0)
        .opacity(2 - Double(abs(vm.offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    vm.offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        if offset.width > 0 {
                            removal?(false)
                        } else {
                            removal?(true)
                            offset = .zero
                        }
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            vm.isShowingAnswer.toggle()
        }
        .animation(.spring(), value: vm.offset)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
