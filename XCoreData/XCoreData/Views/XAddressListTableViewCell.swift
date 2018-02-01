//
//  XAddressListTableViewCell.swift
//  XCoreData
//
//  Created by Bharat Byan on 2/1/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit

class XAddressListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblStreet: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
