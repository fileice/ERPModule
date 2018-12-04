//
//  cust2TableViewCell.swift
//  ERP_Module_V1
//
//  Created by fileice on 2018/11/23.
//  Copyright © 2018 fileice. All rights reserved.
//

import UIKit

class cust2TableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var ansTextfield: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
