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
    
    //下拉更新
    var refreshControl = UIRefreshControl()

    
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
    
    @objc func refreshData(){
        viewModel.getListData()
        //下拉更新 增加秒數
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.CustomertableView.reloadData()
            self.refreshControl.endRefreshing()
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
        
        //修改文字顯示顏色
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        //加入更新程式碼
        self.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        //顯示文字內容
        self.refreshControl.attributedTitle = NSAttributedString(string: "更新中...", attributes: attributes)
        //設定元件顏色
        self.refreshControl.tintColor = UIColor.black
        //設定背景顏色
        self.refreshControl.backgroundColor = UIColor.white
        //將元件加入Tableview中
        self.CustomertableView.refreshControl = refreshControl
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
      
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // 彈跳視窗
        let deleteAction = UITableViewRowAction(style: .default, title: "刪除", handler: {(action, indexPath) -> Void in
            let  delalert = UIAlertController(title: "確定刪除", message: "", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "確認",style: .destructive,handler: {
                (action: UIAlertAction!) -> Void in
                self.viewModel.deleteListData(id: self.viewModel.arrayOfList[indexPath.row].c_ID!)
                self.viewModel.arrayOfList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .bottom)
            })
            delalert.addAction(cancelAction)
            delalert.addAction(okAction)
            self.present(delalert, animated: true, completion: nil)
        })
        let putAction = UITableViewRowAction(style: .default, title: "修改", handler:{(action,indexPath) -> Void in

            self.CustomertableView.reloadData()

            let cust2VC: cust2ViewController = self.storyboard?.instantiateViewController(withIdentifier: "cust2VC") as! cust2ViewController
            cust2VC.title = "修改客戶"
            
            let c_ID = self.viewModel.arrayOfList[indexPath.row].c_ID!
            let c_No = self.viewModel.arrayOfList[indexPath.row].c_No ?? ""
            let c_Name = self.viewModel.arrayOfList[indexPath.row].c_Name ?? ""
            let c_Address = self.viewModel.arrayOfList[indexPath.row].c_Address ?? ""
            let c_Phone = self.viewModel.arrayOfList[indexPath.row].c_Phone ?? ""
            let c_Mobile = self.viewModel.arrayOfList[indexPath.row].c_Mobile ?? ""
            let c_Email = self.viewModel.arrayOfList[indexPath.row].c_Email ?? ""
            let c_Note = self.viewModel.arrayOfList[indexPath.row].c_Note ?? ""

            cust2VC.allCellsText.insert(c_ID,at: 7)
            cust2VC.allCellsText.insert(c_No, at: 0)
            cust2VC.allCellsText.insert(c_Name, at: 1)
            cust2VC.allCellsText.insert(c_Address, at: 2)
            cust2VC.allCellsText.insert(c_Phone, at: 3)
            cust2VC.allCellsText.insert(c_Mobile, at: 4)
            cust2VC.allCellsText.insert(c_Email, at: 5)
            cust2VC.allCellsText.insert(c_Note, at: 6)
            
            print(cust2VC.allCellsText)
            self.navigationController?.show(cust2VC, sender: nil)
            
        })
        putAction.backgroundColor = UIColor.blue
        return [deleteAction,putAction]
    }
    
    /////////////
    func deleteListData(id:String){
        
        
    }
    
    
    

}
