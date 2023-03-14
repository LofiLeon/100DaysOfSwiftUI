//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Leon Grimmeisen on 02.04.22.
//

import SwiftUI

@main

struct BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
