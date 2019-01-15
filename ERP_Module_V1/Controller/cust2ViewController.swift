//
//  cust2ViewController.swift
//  ERP_Module_V1
//
//  Created by fileice on 2018/11/23.
//  Copyright © 2018 fileice. All rights reserved.
//

import UIKit

class cust2ViewController: UIViewController {
    
    var animals: [String] = ["c_No", "c_Name", "c_Address", "c_Phone", "c_Mobile","c_Email","c_Note"]
    var allCellsText = [Any?](repeating: nil, count:7)
    
    @IBOutlet weak var cust2Tableview: UITableView!
    
    var jsonPost:[String: Any] = [:]
    var tableData = [String]()
    
    @IBAction func save_Click(_ sender: Any) {
        
        if self.title == "修改客戶" {
            print("修改客戶")
        } else {
            
            //宣告viewmodel
            let viewModel = ListViewModel()
            for (index, element) in animals.enumerated()
            {
                jsonPost[element] = allCellsText[index]
            }
            
            print(jsonPost)
            viewModel.postListData(json: jsonPost)
        }

        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        // Do any additional setup after loading the view.
        print(allCellsText)
    }
    
    //收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3) {
            self.view.endEditing(true)
        }
    }
}

extension cust2ViewController : UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate{
    
    func tableViewSetup(){
        cust2Tableview.delegate = self
        cust2Tableview.dataSource = self
        cust2Tableview.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cust2cell") as! cust2TableViewCell
        cell.lblTitle.text = animals[indexPath.row]
        cell.ansTextfield?.delegate = self
        cell.ansTextfield?.text = allCellsText[indexPath.row] as? String 
        cell.ansTextfield?.placeholder = animals[indexPath.row]
        cell.ansTextfield?.autocorrectionType = UITextAutocorrectionType.no
        cell.ansTextfield?.autocapitalizationType = UITextAutocapitalizationType.none
        cell.ansTextfield?.adjustsFontSizeToFitWidth = true;
        
        if indexPath.row == 0 {
            if cell.ansTextfield.text == ""  {
                print("00000000")
            }
        }
        
        return cell
    }
    
    //******** start textfield delegate potocol ***********//
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let indexOf = animals.index(of:textField.placeholder!)
        
        if(textField.placeholder! == animals[indexOf!]){
            if( indexOf! <= (allCellsText.count - 1)){
                
                allCellsText.remove(at: indexOf!)
            }

            allCellsText.insert((textField.text!), at: indexOf!)
        }
        return true
    }
    
    //delegate method
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
}
