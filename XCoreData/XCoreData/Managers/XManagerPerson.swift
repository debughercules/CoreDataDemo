//
//  XManagerPerson.swift
//  XCoreData
//
//  Created by Bharat Byan on 2/1/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import Foundation
import CoreData

// MARK:- Protocols

protocol XProtocolManagerPersonList{
    func sendData(arrayOfViewModel: Array<XViewModelPersonList>)
}

protocol XProtocolManagerPersonAddressList{
    func sendPersonsAddresses(arrayOfViewModel: Array<XViewModelAddressList>)
}

class XManagerPerson{
    static let sharedInstance = XManagerPerson()
    var delegate: XProtocolManagerPersonList?
    var delegatePersonAdddressesList: XProtocolManagerPersonAddressList?
    
    var arrArchivedPersons:[Person] = [Person]()
    
    // MARK:- Creating Model
    
    func createPerson(_ firstName: String, lastName: String, age: String){
        let model = XModelPerson()
        model.firstName = firstName
        model.lastName = lastName
        model.age = Int16 (age)
        
        let tupple = self.archiveThePerson(person: model)
        if tupple.status {
            print("Succesfully saved!")
        }
    }
    
    // MARK:- Delegation Sending
    
    func getAllPersons(){
        var arrayViewModel: [XViewModelPersonList] = []
        
        //Core Data Fetching implement Delegation for this
        if let arrPerson = self.fetchAllArchivedPersons() {
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
    
    func getPersonAllAddresses(personFirstName: String){
        
        var arrayViewModel: [XViewModelAddressList] = []
        
        for addresses in self.fetchArchivedPersonAllAddresses(self.fetchPersonWithFirstName(personFirstName))!{
            let model = XModelAddress()
            model.street = addresses.street
            model.city = addresses.city
            
            let viewModel = XViewModelAddressList.init(model)
            arrayViewModel.append(viewModel)
        }
        
        delegatePersonAdddressesList?.sendPersonsAddresses(arrayOfViewModel: arrayViewModel)
    }
    
    // MARK:- Person and model (model and Managed Object Handling)
    
    func archiveThePerson(person:XModelPerson)->(status:Bool, info:Any?, error:Error?) {
        
        guard let personName = person.firstName  else {
            return (false, nil, nil)
        }
        
        let voiceTupple = Person.isUserExists(id: personName, moc: XCoreDataManager.shared.managedObjectContext())
        if let error = voiceTupple.error {
            //            let msg = APIErrorType.apiMessage(key: "details", message: error.localizedDescription)
            
            return (false, nil, error)
        }
        
        let tupple = Person.createObjectsInfo(moc: XCoreDataManager.shared.managedObjectContext(), info: [person])
        
        return (tupple.status, tupple.items, tupple.error)
    }
    
    // MARK:- Handling Relationship
    
    func addAddressToPerson(_ address: Address, firstName: String){
        let person = self.fetchPersonWithFirstName(firstName)
        person.addToPersonAddresses(address)
        XCoreDataManager.shared.saveContext()
    }
    
    // MARK:- Database Queries
    
    func fetchAllArchivedPersons()->[Person]? {
        let persons = Person.fetchRecords(moc: XCoreDataManager.shared.managedObjectContext(), predicate: nil, sortDescriptor: nil)
        return persons as? [Person]
    }
    
    func fetchArchivedPersonAllAddresses(_ person: Person)->[Address]?{
        let addressSet = person.personAddresses?.allObjects as! [Address]
        return addressSet
    }
    
    func fetchPersonWithFirstName(_ firstname: String)->Person{
        let tupple = Person.isUserExists(id: firstname, moc: XCoreDataManager.shared.managedObjectContext())
        return tupple.user!
    }
    
    func updateArchivedPerson(person: Person?){
        DispatchQueue.main.async {
            try? XCoreDataManager.shared.managedObjectContext().save()
        }
    }
    
    func deleteArchivedPerson(person: Person?){
        DispatchQueue.main.async {
            XCoreDataManager.shared.managedObjectContext().delete(person!)
        }
    }
}
