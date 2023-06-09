//
//  ContentView.swift
//  BetterRest
//
//  Created by Leon Grimmeisen on 01.03.22.
//

import CoreML
import SwiftUI

struct ContentView: View {
        
    @State private var wakeUp = defaultWakeUp
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var sleepResults :String {
            do {
                let config = MLModelConfiguration()
                let model = try sleepCalculator(configuration: config)
                
                let components = Calendar.current.dateComponents([.minute, .hour], from: wakeUp)
                let hour = (components.hour ?? 0) * 60 * 60
                let minute = (components.minute ?? 0) * 60
                
                let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
                
                let sleepTime = wakeUp - prediction.actualSleep
                
                return "\(sleepTime.formatted(date: .omitted, time: .shortened))"

            } catch {
                return "ERROR"
            }

    }

    
    static var defaultWakeUp: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    DatePicker("Please enter wake up time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    
                } header: {
                    Text("When do you want to wake up?")
                        .font(.headline)
                }
                
                Section{
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                        .font(.headline)
                }
                
                Section{
                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                } header: {
                    Text("Daily coffee intake")
                        .font(.headline)
                }
                
                    HStack{
                        Section {
                            Text("Go to bed at:")
                        }
                        Section{
                            Text(sleepResults)
                                .font(.title)
                        }
                    }
                
                
            }
            .navigationTitle("Better Rest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
