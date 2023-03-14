//
//  DataController.swift
//  CoreDataProject
//
//  Created by Leon Grimmeisen on 07.04.22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to laod: \(error.localizedDescription)")
            }
        }
    }
}
