//
//  Person+CoreDataProperties.swift
//  XCoreData
//
//  Created by bharat byan on 17/02/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var age: Int16
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var personAddresses: NSSet?

}

// MARK: Generated accessors for personAddresses
extension Person {

    @objc(addPersonAddressesObject:)
    @NSManaged public func addToPersonAddresses(_ value: Address)

    @objc(removePersonAddressesObject:)
    @NSManaged public func removeFromPersonAddresses(_ value: Address)

    @objc(addPersonAddresses:)
    @NSManaged public func addToPersonAddresses(_ values: NSSet)

    @objc(removePersonAddresses:)
    @NSManaged public func removeFromPersonAddresses(_ values: NSSet)

}
