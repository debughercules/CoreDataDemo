//
//  Address+CoreDataClass.swift
//  XCoreData
//
//  Created by bharat byan on 17/02/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Address)
public class Address: NSManagedObject {
    
    // MARK:- Handling Doubling of Entities
    
    class func isAddressExists(id: String?, moc: NSManagedObjectContext)->(status: Bool, address: Address?, error: Error?) {
        
        guard let uniqueId = id else { return (false, nil, nil) }
        
        let p = NSPredicate(format: "street = %@", uniqueId)
        let tuppleRecords = self.fetchRecords(moc: moc, predicate: p, sortDescriptor: nil)
        
        if let arrRecords = tuppleRecords  {
            return (arrRecords.count>0, arrRecords.first as? Address, nil)
        }
        
        return (false, nil, nil)
    }
    
    // MARK:- Creating Managed Object from local model
    
    class func createObjectsInfo(moc: NSManagedObjectContext, info: Any)->(status: Bool,items: [Address]?, error: Error?) {
        
        guard let arrAddressInfo = info as? [XModelAddress] else { return (false, nil, nil) }
        var arrAddresses = [Address]()
        
        for addressInfo in arrAddressInfo {
            do {
                
                var objTempAddress:Address?
                
                /* If  user already exists then we have to update records */
                let tupple = Address.isAddressExists(id: addressInfo.street, moc: moc)
                if let address = tupple.address {
                    objTempAddress = address
                }
                else {
                    objTempAddress = NSEntityDescription.insertNewObject(forEntityName:"Address" , into: moc) as? Address
                }
                
                if let objAddressInfo = objTempAddress {
                    
                    objAddressInfo.street = addressInfo.street
                    objAddressInfo.city = addressInfo.city
                    
                    arrAddresses.append(objAddressInfo)
                }
                
                try moc.save()
                
                return (true,arrAddresses,nil)
            }
            catch {
                print(error)
                return (true,nil,nil)
            }
        }
        return (false,nil,nil)
    }
}
