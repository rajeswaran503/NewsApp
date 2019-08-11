//
//  CoreDataManager.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 10/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "NewsAppTask")
        
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveContext () {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func savePerson(email:String,empID:Int,idbarNo:Int,mobile:String,name:String,uID:Int,refID: Int) {
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        
        guard let entity =  NSEntityDescription.entity(forEntityName: "Person",
                                                       in: managedContext) else { return  }
        
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        person.setValue(name, forKeyPath: "email")
        person.setValue(empID, forKeyPath: "empID")
         person.setValue(idbarNo, forKeyPath: "idBarNo")
         person.setValue(mobile, forKeyPath: "mobileNumber")
         person.setValue(name, forKeyPath: "name")
         person.setValue(uID, forKeyPath: "unifiedNumber")
        
        
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            
        }
        
    }
    
    func fetchPerson() -> Person? {
        
         let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        do {
            let people = try managedContext.fetch(fetchRequest)
            let personValue  = people as? [Person]
            return personValue?.first
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
        
      
    }
    
    func clearDatabase() {
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        do {
            let people = try managedContext.fetch(fetchRequest)
            for i in people {
                managedContext.delete(i)
                try managedContext.save()
            }
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
            
        }
        
    }
    
}
