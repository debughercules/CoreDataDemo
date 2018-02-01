//
//  XPersonListViewController.swift
//  XCoreData
//
//  Created by Bharat Byan on 1/26/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit

class XPersonListViewController: UIViewController {

    @IBOutlet weak var tblPersons: UITableView!
    
    var arrViewModelArchivedPersonss: [XViewModelPersonList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "All Persons"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        self.tblPersons.reloadData()
    }
    
    func getData(){
        self.arrViewModelArchivedPersonss = []
        XManagerPersonList.sharedInstance.delegate = self
        XManagerPersonList.sharedInstance.getPersons()
    }
    
    @IBAction func actBtnPerson(_ sender: UIButton) {
        self.performSegue(withIdentifier: "sXPersonViewController", sender: nil)
    }
}

extension XPersonListViewController: XProtocolManagerPersonList{
    func sendData(arrayOfViewModel: Array<XViewModelPersonList>) {
        self.arrViewModelArchivedPersonss = arrayOfViewModel
        self.tblPersons.reloadData()
    }
}

extension XPersonListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrViewModelArchivedPersonss.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonListCell", for: indexPath) as! XPersonListTableViewCell
        
        cell.selectionStyle = .none
        
        let info = self.arrViewModelArchivedPersonss[indexPath.item]
        cell.lblName.text = info.fullName ?? "Unknown"
        cell.lblAddress.text = info.age
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async  {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "XPersonViewController") as? XPersonViewController{
                vc.strDataName = self.arrViewModelArchivedPersonss[indexPath.row].fullName
                vc.strDataAge = self.arrViewModelArchivedPersonss[indexPath.row].age
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

