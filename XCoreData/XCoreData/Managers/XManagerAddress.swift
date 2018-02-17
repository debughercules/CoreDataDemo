//
//  XManagerAddress.swift
//  XCoreData
//
//  Created by Bharat Byan on 2/2/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import Foundation

// MARK:- Protocols

protocol XProtocolManagerAddress
{
    func sendData(arrayOfViewModel: Array<XViewModelAddressList>)
}

class XManagerAddress{
    static let sharedInstance = XManagerAddress()
    var delegate: XProtocolManagerAddress?
    
    var arrArchivedAddress:[Address] = [Address]()
    
    // MARK:- Creating Model
    
    func createAddress(_ street: String, city: String)->(status:Bool, info:Any?, error:Error?)
    {
        let model = XModelAddress()
        model.street = street
        model.city = city
        
        let tupple = self.archiveTheAddress(address: model)
        if tupple.status {
            print("Succesfully saved!")
        }
        return tupple
    }
    
    // MARK:- Delegation Sending
    
    func getAddresses(){
        var arrayViewModel: [XViewModelAddressList] = []
        
        //Core Data Fetching implement Delegation for this
        if let arrAddress = self.fetchAllArchivedAddresses(){
            self.arrArchivedAddress = arrAddress
        }
        
        for itemPerson in arrArchivedAddress {
            
            let model = XModelAddress()
            model.street = itemPerson.street
            model.city = itemPerson.city
            
            let viewModel = XViewModelAddressList.init(model)
            arrayViewModel.append(viewModel)
        }
        
        delegate?.sendData(arrayOfViewModel: arrayViewModel)
    }
    
    // MARK:- Address and model (model and Managed Object Handling)
    func archiveTheAddress(address:XModelAddress)->(status:Bool, info:Any?, error:Error?) {
        
        guard let addressStreet = address.street  else {
            return (false, nil, nil)
        }
        
        let voiceTupple = Address.isAddressExists(id: addressStreet, moc: XCoreDataManager.shared.managedObjectContext())
        if let error = voiceTupple.error {
            //            let msg = APIErrorType.apiMessage(key: "details", message: error.localizedDescription)
            
            return (false, nil, error)
        }
        
        let tupple = Address.createObjectsInfo(moc: XCoreDataManager.shared.managedObjectContext(), info: [address])
        
        return (tupple.status, tupple.items, tupple.error)
    }
    
    // MARK:- Database Queries
    
    func fetchAllArchivedAddresses()->[Address]? {
        let persons = Address.fetchRecords(moc: XCoreDataManager.shared.managedObjectContext(), predicate: nil, sortDescriptor: nil)
        return persons as? [Address]
    }
    
    func updateArchivedAddress(address: Address?){
        DispatchQueue.main.async {
            try? XCoreDataManager.shared.managedObjectContext().save()
        }
    }
    
    func deleteArchivedAddress(address: Address?){
        DispatchQueue.main.async {
            XCoreDataManager.shared.managedObjectContext().delete(address!)
        }
    }
}
