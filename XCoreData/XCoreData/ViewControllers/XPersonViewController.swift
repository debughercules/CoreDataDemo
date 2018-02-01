//
//  XPersonViewController.swift
//  XCoreData
//
//  Created by Bharat Byan on 1/26/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit
import CoreData

class XPersonViewController: UIViewController {

    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    
    @IBOutlet weak var tblAddresslist: UITableView!
    @IBOutlet weak var btnAddAddress: UIButton!
    
    var strDataName: String?
    var strDataAge: String?
    
    var arrArchivedAddress:[Address] = [Address]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Single Persons"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let fullNameArr = strDataName?.components(separatedBy: " ")
        
        txtFName.text = fullNameArr?[0]
        txtLName.text = fullNameArr?[1]
        txtAge.text = strDataAge
        
        let btn = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(XPersonViewController.startEdit))
        self.navigationItem.rightBarButtonItem  = btn
        
        if txtFName.text! == "" {
            btnAddAddress.isHidden = true
            tblAddresslist.isHidden = true
        }
    }
    
    @objc func startEdit(){
        
    }
    
    func createPerson(_ firstName:String, lastName:String, age:String){
        let model = XModelPerson()
        model.firstName = firstName
        model.lastName = lastName
        model.age = Int16(age)
        
//        self.viewModelPersonList.archiveDownloadedPerson(personItem: model)
    }

    @IBAction func actBtnAddAdress(_ sender: UIButton) {
        
        // Create Address
        let entityAddress = NSEntityDescription.entity(forEntityName: "Address", in: XCoreDataManager.shared.managedObjectContext())
        let newAddress = NSManagedObject(entity: entityAddress!, insertInto: XCoreDataManager.shared.managedObjectContext())
        
        // Populate Address
        newAddress.setValue("Main Street", forKey: "street")
        newAddress.setValue("Boston", forKey: "city")
        
        if let arrPerson = XCoreDataManager.shared.fetchArchivedPersons() {
            
            // Add Address to Person
            arrPerson[0].setValue(NSSet(object: newAddress), forKey: "addresses")
            
            do {
                try arrPerson[0].managedObjectContext?.save()
            } catch {
                let saveError = error as NSError
                print(saveError)
            }
        }
        
         XCoreDataManager.shared.saveContext()
    }
    
    @IBAction func actBtnSavePerson(_ sender: UIButton) {
        
        guard txtFName.text! != "", txtLName.text! != "", txtAge.text! != "" else {
            
            self.popupAlert(title: "Message", message: "Please enter all fields.", actionTitles: ["Ok"], actions:[{action1 in
                
                }, nil])
            
            return
        }
        
        self.createPerson(txtFName.text!, lastName: txtLName.text!, age: txtAge.text!)
        self.navigationController?.popViewController(animated: true)
    }
}

extension XPersonViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrArchivedAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressListCell", for: indexPath) as! XAddressListTableViewCell
        
        cell.selectionStyle = .none
        
        let info = self.arrArchivedAddress[indexPath.item]
//        cell.lblName.text = info.street ?? "Unknown"
//        cell.lblAddress.text = info.city
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
