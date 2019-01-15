//
//  URL_Model.swift
//  ERP_Module_V1
//
//  Created by fileice on 2018/11/23.
//  Copyright © 2018 fileice. All rights reserved.
//

import Foundation

class json_URL: Codable{
    var customer_url = "http://52.198.240.49/api/Customer"
    var customer_del_URL = "http://52.198.240.49/api/Customer?c_ID="

    var product_url = "http://52.198.240.49/api/Product"
}
