//
//  Address+CoreDataClass.swift
//  XCoreData
//
//  Created by Bharat Byan on 1/26/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Address)
public class Address: NSManagedObject {
    
    class func isAddressExists(id:String?,moc:NSManagedObjectContext)->(status:Bool,user:Address?,error:Error?) {
        
        guard let userId = id else { return (false,nil,nil) }
        
        let p = NSPredicate(format: "street = %@",userId)
        let tuppleUsers = self.fetchRecords(moc: moc, predicate: p, sortDescriptor: nil)
        
        if let arrUsers = tuppleUsers  {
            return (arrUsers.count>0, arrUsers.first as? Address,nil)
        }
        
        return (false,nil,nil)
    }
    
    class func createObjectsInfo(moc:NSManagedObjectContext, info:Any)->(status:Bool,items:[Address]?, error:Error?) {
        
        guard let arrUserInfo = info as? [XModelAddress] else { return (false,nil,nil) }
        var arrUsers = [Address]()
        
        for userInfo in arrUserInfo {
            do {
                
                var objTempUser:Address?
                
                /* If  user already exists then we have to update records */
                let tupple = Address.isAddressExists(id: userInfo.street, moc: moc)
                if let user = tupple.user {
                    objTempUser = user
                }
                else {
                    objTempUser = NSEntityDescription.insertNewObject(forEntityName:"Address" , into: moc) as? Address
                }
                
                if let objUserInfo = objTempUser {
                    
                    objUserInfo.street = userInfo.street
                    objUserInfo.city = userInfo.street
                    
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
