//
//  XPersonViewController.swift
//  XCoreData
//
//  Created by Bharat Byan on 1/26/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit

class XPersonViewController: UIViewController {

    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    
    @IBOutlet weak var tblAddresslist: UITableView!
    
    var viewModelVoiceList:XViewModelPersonList = XViewModelPersonList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Single Persons"
    }
    
    func createPerson(_ firstName:String, lastName:String, age:String){
        let model = XModelPerson()
        model.firstName = firstName
        model.lastName = lastName
        model.age = Int16(age)
        
        self.viewModelVoiceList.archiveDownloadedPerson(personItem: model)
    }

    @IBAction func actBtnAddAdress(_ sender: UIButton) {
    }
    
    @IBAction func actBtnSavePerson(_ sender: UIButton) {
        self.createPerson(txtFName.text!, lastName: txtLName.text!, age: txtAge.text!)
        self.navigationController?.popViewController(animated: true)
    }
}
