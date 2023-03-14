//
//  ContentView.swift
//  HighRollers
//
//  Created by Leon Grimmeisen on 12.06.22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("dicesAmount") var dicesAmount: Int = 5
    @AppStorage("diceSides") var diceSides: Int = 6
    @State private var currentResult = DiceResult(diceSides: 6, dicesAmount: 5)
    
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    @State private var stoppedDice = 0
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedRolls.json")
    @State private var savedResults = [DiceResult]()
    
    let columns = [
            GridItem(.adaptive(minimum: 70))
        ]
    
    var body: some View {
        Form {
            Section(header: Text("Configure your dices:")) {
            Stepper("Amount of dices: \(dicesAmount)", value: $dicesAmount, in: 1...100)
            Stepper("Sides per dice: \(diceSides)", value: $diceSides, in: 1...100)
            }
            
            HStack{
                Spacer()
                Button("Roll!") {
                    rollDices()
                }
                Spacer()
            }
            
            Section {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<currentResult.rolls.count, id:\.self) { result in
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 70, height: 70)
                                .foregroundColor(.gray)
                            Text("\(currentResult.rolls[result])")
                                .font(.title)
                        }
                    }
                }
            }
            
            if savedResults.isEmpty == false {
                Section("All results") {
                    ForEach(savedResults) { result in
                        
                        VStack(alignment: .leading) {
                            Text("\(result.dicesAmount) dices with \(result.diceSides) sides:")
                                .font(.headline.weight(.bold))
                            Text(result.rolls.map(String.init).joined(separator: ", "))
                        }
                    }
                }
            }
        }
        .padding()
        .disabled(stoppedDice < currentResult.rolls.count)
        .onReceive(timer) { date in
            updateDice()
        }
        .onAppear(perform: load)
        
        
    }
    
    func rollDices() {
        currentResult = DiceResult(diceSides: diceSides, dicesAmount: dicesAmount)
        stoppedDice = -20
    }
    
    func updateDice() {
        guard stoppedDice < currentResult.rolls.count else { return }
        
        for i in stoppedDice..<currentResult.dicesAmount {
            if i < 0 {continue}
            currentResult.rolls[i] = Int.random(in: 1...diceSides)
        }
        
        stoppedDice += 1
        
        if stoppedDice == dicesAmount {
            savedResults.insert(currentResult, at: 0)
            save()
        }
    }
    
    func load() {
        if let data = try? Data(contentsOf: savePath) {
            if let results = try? JSONDecoder().decode([DiceResult].self, from: data) {
                savedResults = results
            }
        }
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(savedResults) {
            try? data.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
