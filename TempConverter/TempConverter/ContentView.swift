//
//  ContentView.swift
//  TempConverter
//
//  Created by Leon Grimmeisen on 23.02.22.
//

import SwiftUI

struct ContentView: View {
    let scales = ["Celsius", "Fahrenheit", "Kelvin"]
    @FocusState private var inputIsFocused : Bool
    @State private var fromScale = "Celsius"
    @State private var toScale = "Celsius"
    @State private var inputUnits: Double = 0
    
    var output : Double {
        if fromScale == "Celsius" && toScale == "Fahrenheit" {
            return inputUnits * 1.8 + 32
        } else if fromScale == "Celsius" && toScale == "Kelvin" {
            return inputUnits + 273.15
        } else if fromScale == "Fahrenheit" && toScale == "Kelvin" {
            return (inputUnits - 32) * (5/9) + 273
        } else if fromScale == "Fahrenheit" && toScale == "Celsius" {
            return (inputUnits - 32) * (5/9)
        } else if fromScale == "Kelvin" && toScale == "Celsius" {
            return inputUnits - 273.15
        } else if fromScale == "Kelvin" && toScale == "Fahrenheit" {
            return (inputUnits - 273) * (9/5) + 32
        } else {
            return inputUnits
        }
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section {
                    Picker("Convert from:", selection: $fromScale) {
                        ForEach (scales, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextField("Temperature", value: $inputUnits, format: .number)
                        .keyboardType(.numbersAndPunctuation)
                        .focused($inputIsFocused)
                } header: {
                    Text("Temperature in \(fromScale):")
                }
            
                Section {
                    Picker("Convert to:", selection: $toScale) {
                        ForEach (scales, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section{
                    Text(output, format: .number)
                } header: {
                    Text("Temperature in \(toScale):")
                }
                
            }
            .navigationTitle("TempConverter")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
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
