//
//  XAddressViewController.swift
//  XCoreData
//
//  Created by Bharat Byan on 1/26/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit

class XAddressViewController: UIViewController {
    
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    
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
        
        XManagerAddress.sharedInstance.createAddress(txtStreet.text!, city: txtCity.text!)
        self.navigationController?.popViewController(animated: true)
    }
}
