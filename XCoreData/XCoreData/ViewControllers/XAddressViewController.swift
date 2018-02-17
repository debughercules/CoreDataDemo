//
//  XAddressViewController.swift
//  XCoreData
//
//  Created by Bharat Byan on 1/26/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit
import CoreData

class XAddressViewController: UIViewController {
    
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    
    var strDataName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Add Address"
    }
    
    @IBAction func actBtnSaveAddress(_ sender: UIButton) {
        
        guard txtStreet.text! != "", txtCity.text! != "" else {
            self.popupAlert(title: "Message", message: "Please enter all fields.", actionTitles: ["Ok"], actions:[{action1 in
                }, nil])
            return
        }
        
        let tupple = Person.isUserExists(id: strDataName, moc: XCoreDataManager.shared.managedObjectContext())
        
        let model = XModelAddress()
        model.street = txtStreet.text!
        model.city = txtCity.text!
        
        
//        let item: Address!
//        item.addressOfPerson = tupple.user!
        
        
        
//        XManagerPersonList.sharedInstance.addAddressWithPerson(model, person: tupple.user!)
        
        
//        let personEntity = NSEntityDescription.entity(forEntityName: "Person", in: XCoreDataManager.shared.managedObjectContext())
//
//        let tuppleAddress = XManagerAddress.sharedInstance.createAddress(txtStreet.text!, city: txtCity.text!)
//        let address = tuppleAddress.info as! [Address]
//        address[0].addressOfPerson = Person(entity: personEntity!, insertInto: XCoreDataManager.shared.managedObjectContext())
//        address[0].addressOfPerson?.firstName = strDataName
//        XCoreDataManager.shared.saveContext()
        
        
        
        self.navigationController?.popViewController(animated: true)
    }
}
