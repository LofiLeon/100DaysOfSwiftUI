//
//  AddCardSetView-ViewModel.swift
//  FlashzillaSpanish
//
//  Created by Leon Grimmeisen on 25.06.22.
//

import Foundation
import SwiftUI

final class AddCardSetViewViewModel: ObservableObject {
    @Published var newPrompt = ""
    @Published var newPromptSentence = ""
    @Published var newAnswer = ""
    @Published var newAnswerSentence = ""
    
}
