//
//  XPersonListViewController.swift
//  XCoreData
//
//  Created by Bharat Byan on 1/26/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit
import CoreData

class XPersonListViewController: UIViewController {

    @IBOutlet weak var tblPersons: UITableView!
    
    var viewModelVoiceList:XViewModelPersonList = XViewModelPersonList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "All Persons"
        
        let model = XModelPerson()
        model.firstName = "John"
        model.lastName = "Rambo"
        model.age = 30
        
        self.viewModelVoiceList.archiveDownloadedPerson(personItem: model)
    }
    
    func createPerson(){
        let context = XCoreDataManager.shared.persistentContainer.viewContext
        
        //Entity
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
        
        //MO
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue("Raj", forKey: "first")
        newUser.setValue("Kumar", forKey: "last")
        newUser.setValue(20, forKey: "age")
        
        XCoreDataManager.shared.saveContext()
    }

    @IBAction func actBtnPerson(_ sender: UIButton) {
    }

}
