//
//  XCoreDataManager.swift
//  XCoreData
//
//  Created by Bharat Byan on 1/26/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    
    class func fetchRecords(moc:NSManagedObjectContext, predicate:NSPredicate?, sortDescriptor:NSSortDescriptor?)->[NSManagedObject]? {
        
        let className = "\(self)"
        let entityDescription = NSEntityDescription.entity(forEntityName: className, in: moc)
        
        let fetchRequest = self.fetchRequest()
        fetchRequest.entity = entityDescription
        fetchRequest.predicate = predicate
        
        if let sort = sortDescriptor {
            fetchRequest.sortDescriptors = [sort]
        }
        
        let records = try? moc.fetch(fetchRequest)
        
        return records as? [NSManagedObject]
    }
}

class XCoreDataManager {
    
    static var shared:XCoreDataManager = XCoreDataManager()
    
    init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "XCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func managedObjectContext()->NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
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
    
    
    // MARK:- Person
    
    func archivePerson(person:XModelPerson)->(status:Bool, info:Any?, error:Error?) {
        
        guard let personName = person.firstName  else {
            return (false, nil, nil)
        }
        
        let voiceTupple = Person.isUserExists(id: personName, moc: self.managedObjectContext())
        if let error = voiceTupple.error {
//            let msg = APIErrorType.apiMessage(key: "details", message: error.localizedDescription)
            
            return (false, nil, error)
        }
        
        let tupple = Person.createObjectsInfo(moc: self.managedObjectContext(), info: [person])
        
        return (tupple.status, tupple.items, tupple.error)
    }
    
    func fetchArchivedPersons()->[Person]? {
        let persons = Person.fetchRecords(moc: self.managedObjectContext(), predicate: nil, sortDescriptor: nil)
        return persons as? [Person]
    }
    
    // MARK:- Relationship of Person on Address
    func archiveAdressToPerson(_ person: Person, address:XModelAddress)->(status:Bool, info:Any?, error:Error?) {
        
        guard let addressStreet = address.street  else {
            return (false, nil, nil)
        }
        
        let voiceTupple = Address.isAddressExists(id: addressStreet, moc: self.managedObjectContext())
        if let error = voiceTupple.error {
//        let msg = APIErrorType.apiMessage(key: "details", message: error.localizedDescription)
            
            return (false, nil, error)
        }
        
        let tupple = Address.addPersonToAddresses(toPerson: person, moc: self.managedObjectContext(), info: [address])
        
        return (tupple.status, tupple.items, tupple.error)
    }
    
    
    // MARK:- Address
    func archiveAddress(address:XModelAddress)->(status:Bool, info:Any?, error:Error?) {
        
        guard let addressStreet = address.street  else {
            return (false, nil, nil)
        }
        
        let voiceTupple = Address.isAddressExists(id: addressStreet, moc: self.managedObjectContext())
        if let error = voiceTupple.error {
            //            let msg = APIErrorType.apiMessage(key: "details", message: error.localizedDescription)
            
            return (false, nil, error)
        }
        
        let tupple = Address.createObjectsInfo(moc: self.managedObjectContext(), info: [address])
        
        return (tupple.status, tupple.items, tupple.error)
    }
    
    func fetchArchivedAddresses()->[Address]? {
        let persons = Address.fetchRecords(moc: self.managedObjectContext(), predicate: nil, sortDescriptor: nil)
        return persons as? [Address]
    }
    
    func fetchArchivedAddressesOfPerson()->[Address]? {
        
//        let predicate = NSPredicate(format: "ANY addresses.firstName in %@", person.firstName!)
        
        let predicate = NSPredicate(format: "ANY addressOfPerson.firstName in %@", "morgan")
        
        let persons = Address.fetchRecords(moc: self.managedObjectContext(), predicate: predicate, sortDescriptor: nil)
        
        return persons as? [Address]
    }
}
