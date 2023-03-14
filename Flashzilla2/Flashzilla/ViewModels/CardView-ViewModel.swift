//
//  CardView-ViewModel.swift
//  Flashzilla
//
//  Created by Leon Grimmeisen on 23.06.22.
//

import Foundation
import SwiftUI

final class CardViewViewModel: ObservableObject {
    
    @Published var card: Card
//    @Published var removal: ((Bool) -> Void)?  = nil
    @Published var removal: Bool
    @Published var feedback = UINotificationFeedbackGenerator()
    @Published var isShowingAnswer: Bool
    @Published var offset: CGSize
    
    init() {
        self.card = Card.example
        self.removal = false
        self.isShowingAnswer = false
        self.offset = CGSize.zero
    }
}
