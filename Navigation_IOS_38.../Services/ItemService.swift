//
//  ItemService.swift
//  Navigation_IOS_38...
//
//  Created by Aysel on 27.12.2023.
//

import RealmSwift

final class ItemService {
    private let toDoModel: ToDoModel
    private(set) var items = [Item]()
    
    init(toDoModel: ToDoModel) {
        self.toDoModel = toDoModel
        dowlandItems()
    }
    
    private func dowlandItems() {
        items = toDoModel.items.map { $0 }
    }
    
    func addItem(quote: String) {
        guard let realm = try? Realm() else { return }
        let newItem = Item()
        newItem.quote = quote
        do {
            try realm.write {
                toDoModel.items.append(newItem)
                dowlandItems()
            }
        } catch {
            print(error)
        }
    }
    
    func deleteToDoItem(at index: Int) {
        guard let realm = try? Realm() else { return }
        do {
            try realm.write {
                realm.delete(items[index])
                dowlandItems()
            }
        } catch {
            print(error)
        }
    }
    
    
    
    
}
