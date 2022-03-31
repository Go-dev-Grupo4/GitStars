//
//  ManagedObjectContext.swift
//  GitStars
//
//  Created by SP11601 on 30/03/22.
//

import Foundation
import UIKit
import CoreData

typealias onCompletionHandler = (String) -> Void

protocol managedProtocol {
    func getRepositories() -> [Repository]
}

protocol managedSaveProtocol {
    func save(repository: Repository, onCompletionHandler: onCompletionHandler)
}

protocol managedDeleteProtocol {
    func delete(uuid: String, onCompletionHandler: onCompletionHandler)
}

class ManagedObjectContext: managedProtocol, managedSaveProtocol, managedDeleteProtocol {
    
    private let entity = "Repositories"
    
    static let shared: ManagedObjectContext = {
        let instance = ManagedObjectContext()
        return instance
    }()

    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func getRepositories() -> [Repository] {
        var repositoriesList: [Repository] = []
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        
        do {
            guard let repositories = try getContext().fetch(fetchRequest) as? [NSManagedObject] else { return repositoriesList }
            
            for item in repositories {
                
                if let id = item.value(forKey: "id") as? UUID,
                   let repoName = item.value(forKey: "repoName") as? String,
                   let repoDescription = item.value(forKey: "repoDescription") as? String,
                   let avatarURL = item.value(forKey: "avatarURL") as? String,
                   let isFavorite = item.value(forKey: "isFavorite") as? Bool {

                    let repository = Repository(id: id, repoName: repoName, repoDescription: repoDescription, avatarURL: avatarURL, isFavorite: isFavorite)
                    
                    repositoriesList.append(repository)
                }
            }
        } catch let error as NSError {
            print("Error in request \(error.localizedDescription)")
        }
        
        return repositoriesList
    }

    func save(repository: Repository, onCompletionHandler: (String) -> Void) {
        
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: entity, in: context) else { return }
        let transaction = NSManagedObject(entity: entity, insertInto: context)
        
        transaction.setValue(repository.id, forKey: "id")
        transaction.setValue(repository.repoName, forKey: "repoName")
        transaction.setValue(repository.repoDescription, forKey: "repoDescription")
        transaction.setValue(repository.avatarURL, forKey: "avatarURL")
        transaction.setValue(repository.isFavorite, forKey: "isFavorite")
        
        do {
            try context.save()
            onCompletionHandler("Save Success")
            
        } catch let error as NSError {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    func update(repository: Repository, onCompletionHandler: (String) -> Void) {
        let context = getContext()
        
        let predicate = NSPredicate(format: "id == %@","\(repository.id.uuidString)")
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>=NSFetchRequest(entityName: entity)
        fetchRequest.predicate = predicate
        
        do {
            let fetchResult = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            if let entityExists = fetchResult.first {
                entityExists.setValue(repository.repoName, forKey: "repoName")
                entityExists.setValue(repository.repoDescription, forKey: "repoDescription")
                entityExists.setValue(repository.avatarURL, forKey: "avatarURL")
                entityExists.setValue(repository.isFavorite, forKey: "isFavorite")
                try context.save()
                onCompletionHandler("Save Success")
            }
            
        } catch let error as NSError {
            print("Could not save \(error.localizedDescription)")
        }
    }

    func delete(uuid: String, onCompletionHandler: (String) -> Void) {
        
        let context = getContext()
        let predicate = NSPredicate(format: "id == %@","\(uuid)")
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>=NSFetchRequest(entityName: entity)
        
        fetchRequest.predicate = predicate
        
        do {
            let fetchResult = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            if let entityDelete = fetchResult.first {
                context.delete(entityDelete)
            }
            
            try context.save()
            
            onCompletionHandler("Delete Success")
            
        } catch let error as NSError {
            
            print("Fetch failed \(error.localizedDescription)")
            
        }
    }
}
