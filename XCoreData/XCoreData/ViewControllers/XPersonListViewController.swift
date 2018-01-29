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
    
    var arrArchivedPersons:[Person] = [Person]()
    
    var arrArchivedAddress:[Address] = [Address]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "All Persons"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let arrPerson = XCoreDataManager.shared.fetchArchivedPersons() {
            self.arrArchivedPersons = arrPerson
        }
        
        if let arrAddress = XCoreDataManager.shared.fetchArchivedAddresses() {
            self.arrArchivedAddress = arrAddress
        }
        
    }
    
    
    @IBAction func actBtnPerson(_ sender: UIButton) {
    }

}
