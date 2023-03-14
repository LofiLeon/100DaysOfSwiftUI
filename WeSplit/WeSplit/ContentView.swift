//  ContentView.swift
//  WeSplit
//  Created by Leon Grimmeisen on 21.02.22.

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage: Float = 2
    @FocusState private var amountIsFocused: Bool
    
    let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
        
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        return  grandTotal / Double(numberOfPeople + 2)
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: localCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
    
                VStack {
                    Text("Choose tip:")
                    Slider(value: $tipPercentage, in: 0...100, step: 1)
                    
                    if tipPercentage == 0.0 {
                        Text("Tip: \(tipPercentage, specifier: "%1.f")%")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                    } else {
                        Text("Tip: \(tipPercentage, specifier: "%1.f")%")
                            .foregroundColor(.primary)
                    }
                  
                }
                
                Section {
                    Text(totalPerPerson, format: localCurrency)
                } header: {
                    Text("Amount per person:")
                }
                
                Section {
                    Text(grandTotal, format: localCurrency)
                } header: {
                    Text("Total inovice + tip:")
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
