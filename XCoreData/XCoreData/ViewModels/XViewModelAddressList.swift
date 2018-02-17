//
//  XViewModelAddressList.swift
//  XCoreData
//
//  Created by Bharat Byan on 2/2/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import Foundation

class XViewModelAddressList{
    var addressFull: String?
    
    init(_ model: XModelAddress) {
        addressFull = model.street! + " " + model.city!
    }
    
    func archiveDownloadedAddress(addressItem:XModelAddress)->(status:Bool, info:Any?, error:Error?) {
        
        return XManagerAddress.sharedInstance.archiveTheAddress(address: addressItem)
    }
}
