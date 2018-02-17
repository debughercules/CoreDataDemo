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
    @IBOutlet weak var btnSave: UIButton!
    
    var strDataName: String?
    var strDataAge: String?
    
    var arrArchivedAddress:[XViewModelAddressList] = [XViewModelAddressList]()
    
    
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
            
            btnSave.isEnabled = false
            btnSave.alpha = 0.4
            
            txtFName.isUserInteractionEnabled = false
            txtLName.isUserInteractionEnabled = false
            txtAge.isUserInteractionEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        self.tblAddresslist.reloadData()
    }
    
    func getData(){
        self.arrArchivedAddress = []
        XManagerAddress.sharedInstance.delegate = self
        XManagerAddress.sharedInstance.getAddresses()
    }
    
    @objc func startEdit(){
        btnAddAddress.isEnabled = true
        btnAddAddress.alpha = 1.0
        
        btnSave.isEnabled = true
        btnSave.alpha = 1.0
        
        txtFName.isUserInteractionEnabled = true
        txtLName.isUserInteractionEnabled = true
        txtAge.isUserInteractionEnabled = true
        
        let btn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(XPersonViewController.stopEdit))
        self.navigationItem.rightBarButtonItem  = btn
    }
    
    @objc func stopEdit(){
        btnAddAddress.isEnabled = false
        btnAddAddress.alpha = 0.4
        
        btnSave.isEnabled = false
        btnSave.alpha = 0.4
        
        txtFName.isUserInteractionEnabled = false
        txtLName.isUserInteractionEnabled = false
        txtAge.isUserInteractionEnabled = false
        
        let btn = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(XPersonViewController.startEdit))
        self.navigationItem.rightBarButtonItem  = btn
    }

    @IBAction func actBtnAddAdress(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "XAddressViewController") as! XAddressViewController
        vc.strDataName = txtFName.text!
        self.navigationController?.pushViewController(vc, animated: true)
        
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

extension XPersonViewController: XProtocolManagerAddress{
    func sendData(arrayOfViewModel: Array<XViewModelAddressList>) {
        self.arrArchivedAddress = arrayOfViewModel
        self.tblAddresslist.reloadData()
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
        cell.lblStreet.text = info.addressFull ?? "Unknown"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
