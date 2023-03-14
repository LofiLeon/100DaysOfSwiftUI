//
//  DataController.swift
//  Bookworm
//
//  Created by Leon Grimmeisen on 02.04.22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to laod: \(error.localizedDescription)")
            }
        }
    }
}
