//
//  ToDoService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 26.12.2023.
//

import RealmSwift

final class ToDoService {
    private (set) var toDoList = [ToDoModel]()
    
    init() {
        let configuration = Realm.Configuration(schemaVersion: 2)
        Realm.Configuration.defaultConfiguration = configuration
        addToDoList()
    }
    
    private func addToDoList() {
        guard let realm = try? Realm() else { return }
        toDoList = realm.objects(ToDoModel.self).map { $0 }
    }
    
    func dowlandToDoItem(quote: String) {
        guard let realm = try? Realm() else { return }
        let newToDoModel1 = ToDoModel()
        newToDoModel1.quote = quote
        do {
            try realm.write {
                realm.add(newToDoModel1)
                addToDoList()
            }
        } catch {
            print(error)
        }
    }
    
    func deleteToDoItem(at index: Int) {
        guard let realm = try? Realm() else { return }
        do {
            try realm.write {
                realm.delete(toDoList[index])
                addToDoList()
            }
        } catch {
            print(error)
        }
    }
    
    
    
    
    
}

