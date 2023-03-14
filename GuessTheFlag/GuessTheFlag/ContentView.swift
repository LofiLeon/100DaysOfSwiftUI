//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Leon Grimmeisen on 24.02.22.
//

import SwiftUI

struct FlagImage : View {
    let name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var countries = allCountries.shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var currentScore : Int = 0
    @State private var questionCounter = 1
    @State private var showingResults = false
    @State private var allCorrect = false
    @State private var animationAmount = 0.0
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]

    @State private var selectedFlag = -1

    var body: some View {
        ZStack{
            //background design
                RadialGradient(stops: [
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
                    .init(color: Color(red: 0.15, green: 0.3, blue: 0.55), location: 0.3)
                ],center: UnitPoint(x: 0.5, y: 1.2), startRadius: 1, endRadius: 1000)
        
                .ignoresSafeArea()
            
            VStack{
                //foreground design
                Spacer()
                
                Text("Guess the flag:")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack (spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(name: countries[number])
                        }
                        .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                        .scaleEffect(selectedFlag == number ? 1.5 : 1)
                        .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.5)
                        .animation(.default, value: selectedFlag)
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                HStack{
                    Text("Round \(questionCounter) of 8")
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("Score \(currentScore)")
                        .foregroundColor(.white)
                        .font(.title.bold())
                }
             
                
                Spacer()
                
            }
            .padding(20)
        }
        //alert
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is now \(currentScore).")
        }
        .alert("Game finished!", isPresented: $showingResults) {
            Button("Start new game", action: newGame)
        } message: {
            if currentScore == 8 {
            Text("""
                Wuhuuu!
                You got everything right!
                Your final score is \(currentScore)/8.
                
                Now give me a hug! I love you more than anything in the world!
                """)
            } else {
            Text("Your final score is \(currentScore)/8.")
            }
        }
        
    }
    //methods
    func flagTapped(_ number: Int){
        selectedFlag = number

        if number == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
        } else {
            let needsThe = ["UK", "US"]
            let theirAnswer = countries[number]
            
            if needsThe.contains(theirAnswer){
                scoreTitle = "Wrong! That was the flag of the \(countries[number])."
            } else {
            scoreTitle = "Wrong! That was the flag of \(countries[number])."
            }
            
            if currentScore >= 1 {
                currentScore -= 1
            }
        }
        if questionCounter == 8 {
            showingResults = true
        } else {
        showingScore = true
        }
    }
    
    func askQuestion() {
        selectedFlag = -1
        countries.remove(at:correctAnswer)
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
    }
    
    func newGame () {
        countries = Self.allCountries
        questionCounter = 0
        currentScore = 0
        askQuestion()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
