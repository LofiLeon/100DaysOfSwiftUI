//
//  ContentView.swift
//  funMath
//
//  Created by Leon Grimmeisen on 08.03.22.
// ToDo's:
// design

import SwiftUI

struct Question {
    var question: String
    var answer: Int
}

struct ContentView: View {
    
    @FocusState private var answerIsFocused: Bool
    
    @State private var gameOn = false
    @State private var numberToMultiply = 0
    @State private var noQuestions = 0.0
    
    @State private var questionsArray = [String]()
    @State private var answersArray = [Int]()
    @State private var questionIndex : Int = 0
    @State private var questionCounter : Int = 1
    @State private var gameDone : Bool = false
    
    @State private var userAnswer: Int = 0
    @State private var score = 0



    var body: some View {
        if gameOn == false {
            VStack {
                Text("Game settings")
                    .font(.largeTitle)

                
                Spacer()
                
                VStack (spacing: 15) {
                    Text("Please select your number:")
                        .font(.headline)
                    HStack {
                        ForEach(1..<6) { number in
                            Button {
                                numberToMultiply = number
                            } label: {
                                if number == numberToMultiply {
                                    Image(systemName: "\(number).circle.fill")
                                } else {
                                    Image(systemName: "\(number).circle")
                                }
                            }
                        }
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                    }
                    
                    HStack {
                        ForEach(6..<11) { number in
                            Button {
                                numberToMultiply = number
                            } label: {
                                if number == numberToMultiply {
                                    Image(systemName: "\(number).circle.fill")
                                } else {
                                    Image(systemName: "\(number).circle")
                                }
                            }
                        }
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                    }
                    
                    HStack {
                        ForEach(11..<16) { number in
                            Button {
                                numberToMultiply = number
                            } label: {
                                if number == numberToMultiply {
                                    Image(systemName: "\(number).circle.fill")
                                } else {
                                    Image(systemName: "\(number).circle")
                                }
                            }
                        }
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                    }
                    HStack {
                        ForEach(16..<21) { number in
                            Button {
                                numberToMultiply = number
                            } label: {
                                if number == numberToMultiply {
                                    Image(systemName: "\(number).circle.fill")
                                } else {
                                    Image(systemName: "\(number).circle")
                                }
                            }
                        }
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(Color(red: 0.812, green: 0.694, blue: 0.718))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                Slider(value: $noQuestions, in: 1...20, step: 1)
                    .foregroundColor(.black)
                    .accentColor(.black)

                                
                Text("Number of questions: \(noQuestions.formatted())")
                
                Spacer()
                
                Button("Go!") {
                    ///start game
                    gameOn = true
                    createQuestions()
                }
                .font(.title)
                .foregroundColor(.primary)
                .frame(maxWidth: 150)
                .frame(maxHeight: 50)
                .padding(20)
                .background(Color(red: 0.812, green: 0.694, blue: 0.718))
                .clipShape(RoundedRectangle(cornerRadius: 20))


                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(30)
            .background(Color(red: 0.545, green: 0.502, blue: 0.976))


        } else {
            VStack {
                Spacer()

                Group {
                    Text("what is the solution to: ")
                        .font(.title)
                    
                    Spacer()
                    
                    Text("\(questionsArray[questionIndex]) ?")
                        .font(.largeTitle)
                }
                
                Spacer()
                
                TextField("Your answer", value: $userAnswer, format: .number)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Button("Enter") {
                                questionAnswered()
                            }
                        }
                    }
                    .keyboardType(.decimalPad)
                    .frame(width: 150, height: 40)
                    .background(Color(red: 0.812, green: 0.694, blue: 0.718))
                    .foregroundColor(.primary)
                    .focused($answerIsFocused)
                    .cornerRadius(40)
                    .multilineTextAlignment(.center)
                    
                
                Spacer()

                HStack {
                    Text("Round \(questionCounter)/\(noQuestions.formatted())")
                    Spacer()
                    Text("Score: \(score)")
                }
                .padding(60)
                .font(.title3)
                
                Button("Enter") {
                    questionAnswered()
                }
                .foregroundColor(.primary)
                .frame(maxWidth: 100)
                .frame(maxHeight: 35)
                .padding(20)
                .background(Color(red: 0.812, green: 0.694, blue: 0.718))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
            }
            .background(Color(red: 0.545, green: 0.502, blue: 0.976))
            .alert("Game finished", isPresented: $gameDone) {
                Button("Next Round!", action: setNewGame)
            } message: {
                Text("Your score is \(score) / \(noQuestions.formatted()).")
            }
        }
    }
    
    func createQuestions() {
        for _ in 1...20 {
            let firstNumber: Int = .random(in: 1...20)
            let secondNumber: Int = numberToMultiply
            
            let question = "\(firstNumber) * \(secondNumber)"
            let answer = firstNumber * secondNumber
            
            questionsArray.append(question)
            answersArray.append(answer)
        }
    }
    
    func questionAnswered() {
        if questionCounter == Int(noQuestions) {
            gameDone = true
        }
        
        if userAnswer == answersArray[questionCounter-1] {
            score += 1
        } else {
            score -= 1
        }
        
        if questionCounter < Int(noQuestions) {
            questionCounter += 1

        }
        
        questionIndex += 1
        userAnswer = 0
    }
    
    func setNewGame() {
        gameOn = false
        score = 0
        numberToMultiply = 0
        noQuestions = 0.0
        questionCounter = 1
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
