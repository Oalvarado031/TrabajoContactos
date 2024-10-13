//
//  CoreDataStack.swift
//  CoreDataContacts
//
//  Created by Oscar Alvarado on 30/9/24.
//

import Foundation
import CoreData

final class CoreDataStack {
    private let modelName: String
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: modelName)
        
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                print("CoreData error: \(error.localizedDescription)")
            }
        }
        
        return persistentContainer
    }()
    
    lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            print("Save error: \(error.localizedDescription)")
        }
    }
}
