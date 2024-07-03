//
//  DatabaseManager.swift
//  PodcastApp
//
//  Created by Baran Baran on 13.06.2024.
//

import UIKit
import CoreData


// MARK: DatabaseManagerProtocol
protocol DatabaseManagerProtocol {
    func saveDatabase<T: NSManagedObject>(model: T, completion: @escaping(Result<Void, Error>) -> Void)
    func fetchDatabase<T: NSManagedObject>(entity: T.Type, completion: @escaping(Result<[T], Error>) -> Void)
    func deleteDatabase<T: NSManagedObject>(deleteItem: T, completion: @escaping(Result<Void, Error>) -> Void)
}



// MARK: DatabaseManager
final class DatabaseManager {
    static let shared = DatabaseManager()
    private init() {}
}


// MARK: DatabaseManagerProtocol Implementation

extension DatabaseManager: DatabaseManagerProtocol {

    // Save
    func saveDatabase<T: NSManagedObject>(model: T, completion: @escaping(Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        context.insert(model)

        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    // Read
    func fetchDatabase<T: NSManagedObject>(entity: T.Type, completion: @escaping(Result<[T], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let request = T.fetchRequest()

        do {
            if let data = try context.fetch(request) as? [T] {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to cast fetched objects to the expected type."])))
            }
        } catch {
            completion(.failure(error))
        }
    }

    // Delete
    func deleteDatabase<T: NSManagedObject>(deleteItem: T, completion: @escaping(Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        context.delete(deleteItem)

        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}

