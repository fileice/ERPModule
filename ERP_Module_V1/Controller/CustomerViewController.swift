//
//  CustomerViewController.swift
//  ERP_Module_V1
//
//  Created by fileice on 2018/11/21.
//  Copyright © 2018 fileice. All rights reserved.
//

import UIKit

class CustomerViewController: UIViewController {

    @IBOutlet weak var CustomertableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func AddCuatomerVC(_ sender: Any) {
        let Add_C_VC: AddCustomerViewController = self.storyboard?.instantiateViewController(withIdentifier: "Add_C_VC") as! AddCustomerViewController
        Add_C_VC.title = "新增客戶"
        self.navigationController?.show(Add_C_VC, sender: self)
    }
    
    @IBAction func addCust2(_ sender: Any) {
     
        let cust2VC: cust2ViewController = self.storyboard?.instantiateViewController(withIdentifier: "cust2VC") as! cust2ViewController
        cust2VC.title = "新增客戶2"
        self.navigationController?.show(cust2VC, sender: nil)
    }
    
    ///view model object
    var viewModel = ListViewModel()
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        pageSetup()
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pageSetup()
        self.CustomertableView.reloadData()
    }
    
    ///initial page settings
    func pageSetup()  {
        activityIndicator.startAnimating()
        tableViewSetup()
        ///API calling from viewmodel class
        viewModel.getListData()
        closureSetUp()
    }
    
    ///closure initialize
    func closureSetUp()  {
        viewModel.reloadList = { [weak self] ()  in
            ///UI chnages in main tread
            DispatchQueue.main.async {
                self?.CustomertableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }
        viewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}

///UITable view delegate methods
extension CustomerViewController : UITableViewDelegate,UITableViewDataSource{
    ///table view settings
    func tableViewSetup()  {
        CustomertableView.dataSource = self
        CustomertableView.delegate = self
        CustomertableView.tableFooterView = UIView()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrayOfList.count
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 63
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        //return UITableView.automaticDimension
//        return 130
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerTableViewCell") as! CustomerTableViewCell
        
        let listObj = viewModel.arrayOfList[indexPath.row]
        ///Cell data settings
        cell.lblName.text = listObj.c_Name
        cell.lblPhone.text = listObj.c_Phone
        cell.lblMobile.text = listObj.c_Mobile
        cell.lblAddress.text = listObj.c_Address
        
        //cell background color change
        if ((indexPath.row % 2) != 0){
            cell.contentView.backgroundColor = UIColor.lightGray
        }else{
            cell.contentView.backgroundColor = UIColor.clear
        }
        
        return cell
    }
    
    //左滑選單
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "刪除"
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // create post request
            let url = URL(string: "http://13.230.101.163/api/Customer?c_ID=8")
            var request = URLRequest(url: url! as URL)
            request.httpMethod = "DELETE"
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil { print(error!); return }
                do {
                    if let jsonObj = String(data: data!, encoding: .utf8) {
                        print(jsonObj)
                        DispatchQueue.main.async {
                            self.CustomertableView.reloadData()
                        }
                    }
                } catch {
                    print(error)
                }
            }
            task.resume()
        }
    }
    
    /////////////
    func deleteListData(id:String){
        
        
    }
    
    
    

}
