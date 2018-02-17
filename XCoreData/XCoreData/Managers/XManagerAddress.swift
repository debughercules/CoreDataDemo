//
//  XManagerAddress.swift
//  XCoreData
//
//  Created by Bharat Byan on 2/2/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import Foundation

protocol XProtocolManagerAddress
{
    func sendData(arrayOfViewModel: Array<XViewModelAddressList>)
}

class XManagerAddress{
    static let sharedInstance = XManagerAddress()
    var delegate: XProtocolManagerAddress?
    
    var arrArchivedAddress:[Address] = [Address]()
    
//    func createAddressS(_ person: Person, street: String, city: String)
//    {
//        let model = XModelAddress()
//        model.street = street
//        model.city = city
//        
//        let tupple = XCoreDataManager.shared.archiveAddress(address: model)
//        if tupple.status {
//            print("Succesfully saved!")
//        }
//    }
    
    func createAddress(_ street: String, city: String)->(status:Bool, info:Any?, error:Error?)
    {
        let model = XModelAddress()
        model.street = street
        model.city = city
        
        let tupple = XCoreDataManager.shared.archiveAddress(address: model)
        if tupple.status {
            print("Succesfully saved!")
        }
        return tupple
    }
    
    func getAddresses(){
        var arrayViewModel: [XViewModelAddressList] = []
        
        //Core Data Fetching implement Delegation for this
        if let arrAddress = XCoreDataManager.shared.fetchArchivedAddresses(){
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
    
    func updateAddress(address: Address?){
        DispatchQueue.main.async {
            try? XCoreDataManager.shared.managedObjectContext().save()
        }
    }
    
    func deleteAddress(address: Address?){
        DispatchQueue.main.async {
            XCoreDataManager.shared.managedObjectContext().delete(address!)
        }
    }
}
