//
//  Person+CoreDataClass.swift
//  XCoreData
//
//  Created by bharat byan on 17/02/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    
    class func isUserExists(id:String?,moc:NSManagedObjectContext)->(status:Bool,user:Person?,error:Error?) {
        
        guard let userId = id else { return (false,nil,nil) }
        
        let p = NSPredicate(format: "firstName = %@",userId)
        let tuppleUsers = self.fetchRecords(moc: moc, predicate: p, sortDescriptor: nil)
        
        if let arrUsers = tuppleUsers  {
            return (arrUsers.count>0, arrUsers.first as? Person,nil)
        }
        
        return (false,nil,nil)
    }
    
    class func createObjectsInfo(moc:NSManagedObjectContext, info:Any)->(status:Bool,items:[Person]?, error:Error?) {
        
        guard let arrUserInfo = info as? [XModelPerson] else { return (false,nil,nil) }
        var arrUsers = [Person]()
        
        for userInfo in arrUserInfo {
            do {
                
                var objTempUser:Person?
                
                /* If  user already exists then we have to update records */
                let tupple = Person.isUserExists(id: userInfo.firstName, moc: moc)
                if let user = tupple.user {
                    objTempUser = user
                }
                else {
                    objTempUser = NSEntityDescription.insertNewObject(forEntityName:"Person" , into: moc) as? Person
                }
                
                if let objUserInfo = objTempUser {
                    
                    objUserInfo.firstName = userInfo.firstName
                    objUserInfo.lastName = userInfo.lastName
                    objUserInfo.age = userInfo.age!
                    
                    arrUsers.append(objUserInfo)
                }
                
                try moc.save()
                
                return (true,arrUsers,nil)
            }
            catch {
                print(error)
                return (true,nil,nil)
            }
        }
        return (false,nil,nil)
    }
}
