//
//  XManagerPersonList.swift
//  XCoreData
//
//  Created by Bharat Byan on 2/1/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import Foundation

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
}
