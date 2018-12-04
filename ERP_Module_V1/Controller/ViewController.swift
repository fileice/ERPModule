//
//  ViewController.swift
//  ERP_Module_V1
//
//  Created by fileice on 2018/11/19.
//  Copyright © 2018 fileice. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var titleCollectionView: UICollectionView!
    
    var titleArray = ["客戶管理","商品管理"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        titleCollectionView.dataSource = self
        titleCollectionView.delegate = self
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = titleCollectionView.dequeueReusableCell(withReuseIdentifier: "c_cell", for: indexPath) as! mainPage_CollectionViewCell
        
        cell.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        cell.titleLabel.text = titleArray[indexPath.item]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.item{
            case 0:
                let customerVC: CustomerViewController = self.storyboard?.instantiateViewController(withIdentifier: "customerVC") as! CustomerViewController
                customerVC.title = "客戶管理"
                self.navigationController?.show(customerVC, sender: nil)
            case 1:
                let productVC: ProductViewController = self.storyboard?.instantiateViewController(withIdentifier: "productVC") as! ProductViewController
                productVC.title = "商品管理"
                self.navigationController?.show(productVC, sender: nil)
        default:
            return
        }
        
        
    }
    
}







