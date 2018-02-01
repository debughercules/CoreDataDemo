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
    @IBOutlet weak var btnAddAddress: UIButton!
    
    var strDataName: String?
    var strDataAge: String?
    
    var arrArchivedAddress:[Address] = [Address]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Single Persons"
        
        let fullNameArr = strDataName?.components(separatedBy: " ")
        
        txtFName.text = fullNameArr?[0]
        txtLName.text = fullNameArr?[1]
        txtAge.text = strDataAge
        
        if txtFName.text! == "" {
            btnAddAddress.isHidden = true
            tblAddresslist.isHidden = true
        }else{
            let btn = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(XPersonViewController.startEdit))
            self.navigationItem.rightBarButtonItem  = btn
            
            btnAddAddress.isEnabled = false
            btnAddAddress.alpha = 0.4
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @objc func startEdit(){
        btnAddAddress.isEnabled = true
        btnAddAddress.alpha = 1.0
        
        let btn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(XPersonViewController.stopEdit))
        self.navigationItem.rightBarButtonItem  = btn
    }
    
    @objc func stopEdit(){
        btnAddAddress.isEnabled = false
        btnAddAddress.alpha = 0.4
        
        let btn = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(XPersonViewController.startEdit))
        self.navigationItem.rightBarButtonItem  = btn
    }

    @IBAction func actBtnAddAdress(_ sender: UIButton) {
        
        
    }
    
    @IBAction func actBtnSavePerson(_ sender: UIButton) {
        
        guard txtFName.text! != "", txtLName.text! != "", txtAge.text! != "" else {
            self.popupAlert(title: "Message", message: "Please enter all fields.", actionTitles: ["Ok"], actions:[{action1 in
                }, nil])
            return
        }
        
        XManagerPersonList.sharedInstance.createPerson(txtFName.text!, lastName: txtLName.text!, age: txtAge.text!)
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
