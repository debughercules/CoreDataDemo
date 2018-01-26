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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "All Persons"
    }

    @IBAction func actBtnPerson(_ sender: UIButton) {
    }

}
