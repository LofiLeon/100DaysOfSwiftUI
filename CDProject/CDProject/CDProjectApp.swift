//
//  CDProjectApp.swift
//  CDProject
//
//  Created by Leon Grimmeisen on 08.04.22.
//

import SwiftUI

@main

struct CDProjectApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
