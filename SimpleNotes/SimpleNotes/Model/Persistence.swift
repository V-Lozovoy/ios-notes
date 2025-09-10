//  Persistence.swift
//  SimpleNotes

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer // Ключовий об'єкт Core Data, який інкапсулює весь стек (модель даних, контекст та координатор сховища)

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SimpleNotes") // Створюємо контейнер
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Сталася помилка: \(error)") // Якщо не вийшло завантажити базу даних, виводимо помилку
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true // Для синхронізації змін
    }
}


