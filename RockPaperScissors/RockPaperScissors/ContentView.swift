//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Leon Grimmeisen on 27.02.22.
//

import SwiftUI

struct ContentView: View {
        
    static let moves = ["👊🏽","✋🏽","✌🏽"]

    @State private var choiceApp = moves.randomElement()
    @State private var playerShouldWin = true
    @State private var playerChose = "✌🏽"
    @State private var scoreTitle = ""
    @State private var score : Int = 0
    @State private var roundCounter = 1
    @State private var showResults = false

    var body: some View {
        
        ZStack{
            
            Color(red: 0.15, green: 0.3, blue: 0.55)
                .ignoresSafeArea()
            
            VStack{
                Text("Rock Paper Scissors")
                    .foregroundColor(.white)
                    .bold()
                    .font(.title)
                
                Spacer()
        
                VStack {
                    Text("The app chose:")
                        .font(.title2)
                    
                    Text(choiceApp!)
                        .frame(width: 75, height: 75)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .font(.largeTitle)
                }
                .padding(20)
                .frame(maxWidth: .infinity)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
    
                VStack {
                    Text("Which one would")
                        .font(.title2)
                        .padding()
                    
                    if playerShouldWin == true {
                        Text("WIN?")
                            .font(.title)
                            .foregroundColor(.green)
                            .bold()
                    } else {
                        Text("LOOSE?")
                            .font(.title)
                            .foregroundColor(.red)
                            .bold()
                    }
                                    
                    HStack {
                        Button(
                            action: {
                                tappedRock()
                            },
                            label: {Text("👊🏽")}
                            )
                            .frame(width: 75, height: 75)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .font(.largeTitle)
                        Spacer()
                        Button(
                            action: {
                                tappedPaper()
                            },
                            label: {Text("✋🏽")}
                            )
                            .frame(width: 75, height: 75)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .font(.largeTitle)
                        Spacer()
                        Button(
                            action: {
                                tappedScissors()
                            },
                            label: {Text("✌🏽")}
                            )
                            .frame(width: 75, height: 75)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .font(.largeTitle)
                        Spacer()
                    }
                    .padding(20)
                }
                .frame(maxWidth: .infinity)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()

                Text("\(scoreTitle)")
                    .frame(maxWidth: .infinity, maxHeight: 100)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                Spacer()
             
                HStack{
                    Text("Round \(roundCounter)/10")
                        .foregroundColor(.white)
                    Spacer()
                    Text("Score \(score)")
                        .foregroundColor(.white)
                }

            }
            .padding(20)
        }
        .alert("Game finished!", isPresented: $showResults) {
            Button("Start new game", action: newGame)
        } message: {
            Text("Your final score is \(score)/10.")
        }
    }
    
    func newGame() {
        score = 0
        roundCounter = 1
        choiceApp = ContentView.moves.randomElement()
        playerShouldWin = .random()
    }
    
    func newRound () {
        choiceApp = ContentView.moves.randomElement()
        playerShouldWin = .random()
    }
        
    func tappedRock() {
        if playerShouldWin == true {
            if choiceApp == "✌🏽" {
                scoreTitle = "That was correct!"
                score += 1
            } else {
                scoreTitle = "That was wrong..."
                if score >= 1 {
                    score -= 1
                }
            }
        } else {
            if choiceApp == "✋🏽" {
                scoreTitle = "That was correct!"
                score += 1
            } else {
                scoreTitle = "That was wrong..."
                if score >= 1 {
                    score -= 1
                }
            }
        }
        if roundCounter == 10 {
            roundCounter = 0
            showResults = true
        }
        roundCounter += 1
        newRound()
    }
    
    func tappedPaper() {
        if playerShouldWin == true {
            if choiceApp == "👊🏽" {
                scoreTitle = "That was correct!"
                score += 1
            } else {
                scoreTitle = "That was wrong..."
                if score >= 1 {
                    score -= 1
                }
            }
        } else {
            if choiceApp == "✌🏽" {
                scoreTitle = "That was correct!"
                score += 1
            } else {
                scoreTitle = "That was wrong..."
                if score >= 1 {
                    score -= 1
                }
            }
        }
        if roundCounter == 10 {
            roundCounter = 0
            showResults = true
        }
        roundCounter += 1
        newRound()
    }
    
    func tappedScissors() {
        if playerShouldWin == true {
            if choiceApp == "✋🏽" {
                scoreTitle = "That was correct!"
                score += 1
            } else {
                scoreTitle = "That was wrong..."
                if score >= 1 {
                    score -= 1
                }
            }
        } else {
            if choiceApp == "👊🏽" {
                scoreTitle = "That was correct!"
                score += 1
            } else {
                scoreTitle = "That was wrong..."
                if score >= 1 {
                    score -= 1
                }
            }
        }
        if roundCounter == 10 {
            roundCounter = 0
            showResults = true
        }
        roundCounter += 1
        newRound()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
