//
//  CustomerTableViewCell.swift
//  ERP_Module_V1
//
//  Created by fileice on 2018/11/21.
//  Copyright © 2018 fileice. All rights reserved.
//

import UIKit

class CustomerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
