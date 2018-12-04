//
//  CustomerViewModel.swift
//  ERP_Module_V1
//
//  Created by fileice on 2018/11/21.
//  Copyright © 2018 fileice. All rights reserved.
//

import Foundation
import UIKit
class ListViewModel {
    
    ///closure use for notifi
    var reloadList = {() -> () in }
    var errorMessage = {(message : String) -> () in }
    var customer_URL = json_URL()
    
    ///Array of List Model class
    var arrayOfList : [Customer] = []{
        ///Reload data when data set
        didSet{
            reloadList()
        }
    }
    
    ///get data from api (https://jsonplaceholder.typicode.com/posts/)
    func getListData()  {
        guard let listURL = URL(string: customer_URL.customer_url)else {
            return
        }
        URLSession.shared.dataTask(with: listURL){
            (data,response,error) in
            guard let jsonData = data else { return }
            do {
                ///Using Decodable data parse
                let decoder = JSONDecoder()
                self.arrayOfList = try decoder.decode([Customer].self, from: jsonData)
            } catch let error {
                print("Error ->\(error.localizedDescription)")
                self.errorMessage(error.localizedDescription)
            }
        }.resume()
    }
    

    func postListData(json:[String: Any]){
       
        // create post request
        let url = URL(string: customer_URL.customer_url)!
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: nil, delegateQueue: nil)
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        guard let httpbody = try? JSONSerialization.data(withJSONObject: json, options: []) else { return }
        request.httpBody = httpbody
        
        let dataTask = session.dataTask(with: request, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
            if let response = response{
                print(response)
            }
            if let data = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    print(json)
                }catch{
                    print(error)
                }
            }
        })
        dataTask.resume()
    }
    
    
    
    
}
