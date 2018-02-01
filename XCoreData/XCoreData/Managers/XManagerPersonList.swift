//
//  XManagerPersonList.swift
//  XCoreData
//
//  Created by Bharat Byan on 2/1/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import Foundation
import CoreData

protocol XProtocolManagerPersonList
{
    func sendData(arrayOfViewModel: Array<XViewModelPersonList>)
}

class XManagerPersonList{
    static let sharedInstance = XManagerPersonList()
    var delegate: XProtocolManagerPersonList?
    
    var arrArchivedPersons:[Person] = [Person]()
    
    func createPerson(_ firstName: String, lastName: String, age: String)
    {
        let model = XModelPerson()
        model.firstName = firstName
        model.lastName = lastName
        model.age = Int16 (age)
        
        let tupple = XCoreDataManager.shared.archivePerson(person: model)
        if tupple.status {
            print("Succesfully saved!")
        }
    }
    
    func getPersons(){
        var arrayViewModel: [XViewModelPersonList] = []
        
        //Core Data Fetching implement Delegation for this
        if let arrPerson = XCoreDataManager.shared.fetchArchivedPersons() {
            self.arrArchivedPersons = arrPerson
        }
        
        for itemPerson in arrArchivedPersons {
            
            let model = XModelPerson()
            model.firstName = itemPerson.firstName
            model.lastName = itemPerson.lastName
            model.age = itemPerson.age
            
            let viewModel = XViewModelPersonList.init(model)
            arrayViewModel.append(viewModel)
        }
        
        delegate?.sendData(arrayOfViewModel: arrayViewModel)
    }
    
    func updatePerson(person: Person?){
        DispatchQueue.main.async {
            try? XCoreDataManager.shared.managedObjectContext().save()
        }
    }
    
    func deletePerson(person: Person?){
        DispatchQueue.main.async {
            XCoreDataManager.shared.managedObjectContext().delete(person!)
        }
    }
    
    func addAddressWithPerson(_ address: XModelAddress, person: Person){
        
//        let addressStreet = address.street
        
//        let addressTupple = Address.isAddressExists(id: addressStreet, moc: XCoreDataManager.shared.managedObjectContext())
//        if let error = addressTupple.error {
//            print(error)
//        }
        
        let addressTupple = Address.createObjectsInfo(moc: XCoreDataManager.shared.managedObjectContext(), info: [address])
        if addressTupple.status {
            print("Address created succesfully")
        }
        
        // Create Address
        let newAddress = addressTupple.items![0]
        
        // Populate Address
        newAddress.setValue(address.street, forKey: "street")
        newAddress.setValue(address.city, forKey: "city")
        
        // Add Address to Person
        person.setValue(NSSet(object: newAddress), forKey: "addresses")
        
        do {
            try person.managedObjectContext?.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
        
        XCoreDataManager.shared.saveContext()
    }
}
