//
//  AddCustomerViewController.swift
//  ERP_Module_V1
//
//  Created by fileice on 2018/11/22.
//  Copyright © 2018 fileice. All rights reserved.
//

import UIKit

class AddCustomerViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var c_NO_Textfiled: UITextField!
    @IBOutlet weak var c_Name_Textfield: UITextField!
    @IBOutlet weak var c_Address_Textfiled: UITextField!
    @IBOutlet weak var c_Phone_Textfield: UITextField!
    @IBOutlet weak var c_Mobile_Textfield: UITextField!
    @IBOutlet weak var c_Email_Textfield: UITextField!
    @IBOutlet weak var c_Note_Textfield: UITextField!
    
    
    
    @IBAction func OK_Click(_ sender: Any) {
        let viewModel = ListViewModel()
        if c_Name_Textfield.text != ""{
            // prepare json data
            let json: [String: Any] = ["c_No":c_NO_Textfiled.text!,"c_Name":c_Name_Textfield.text!,"c_Address":c_Address_Textfiled.text!,"c_Phone":c_Phone_Textfield.text!,"c_Mobile":c_Mobile_Textfield.text!,"c_Email":c_Email_Textfield.text!,"c_Note":c_Note_Textfield.text!]

            print(json)
            viewModel.postListData(json: json)
            self.navigationController?.popViewController(animated: true)
            
        } else {
            let alertName = UIAlertController(title: "新增欄位Name", message: "姓名為必填欄位", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "返回", style: .cancel, handler: nil)
            alertName.addAction(cancelAction)
            self.present(alertName, animated: true, completion: nil)
        }
    }
    
    @IBAction func Cancle_Click(_ sender: Any) {
        c_NO_Textfiled.text = ""
        c_Name_Textfield.text = ""
        c_Address_Textfiled.text = ""
        c_Phone_Textfield.text = ""
        c_Mobile_Textfield.text = ""
        c_Name_Textfield.text = ""
        c_Note_Textfield.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        c_Note_Textfield.delegate = self
    }
    
    //收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3) {
            self.view.endEditing(true)
        }
    }
    
    //******** start textfield delegate potocol ***********//
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //開始輸入,若鍵盤擋到畫面,整個view往上移
        var shift: CGFloat = 0.0 //位移值
        
        if textField.tag == 1 {
            shift = 60
        } else if textField.tag == 2 {
            shift = 500
        }
        
        self.view.center = CGPoint(x: self.view.center.x, y: self.view.center.y - shift)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //結束輸入
        var shift: CGFloat = 0.0 //位移值
        
        if textField.tag == 1 {
            shift = 60
        } else if textField.tag == 2 {
            shift = 500
        }
        
        self.view.center = CGPoint(x: self.view.center.x, y: self.view.center.y + shift)
    }

        

}
