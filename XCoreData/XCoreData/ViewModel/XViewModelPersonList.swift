//
//  XViewModelPersonList.swift
//  XCoreData
//
//  Created by Bharat Byan on 1/26/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import Foundation

class XViewModelPersonList {
    
    func archiveDownloadedPerson(personItem:XModelPerson)->(status:Bool, info:Any?, error:Error?) {
        
        return XCoreDataManager.shared.archivePerson(person: personItem)
    }
}
