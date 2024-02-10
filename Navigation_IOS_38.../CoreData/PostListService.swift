//
//  PostListService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 28.12.2023.
//

import CoreData
import Foundation

protocol IPostListService {
    var context: NSManagedObjectContext { get }
    func saveContext()
}

final class PostListService: IPostListService {
    
    static let shared: IPostListService = PostListService()
    
    private init() {}
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: .coreDataBaseName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print(error.localizedDescription)
                assertionFailure()
            }
        }
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
                assertionFailure("Save error")
            }
        }
        
    }
}

private extension String {
    static let coreDataBaseName = "ToDoList"
}
