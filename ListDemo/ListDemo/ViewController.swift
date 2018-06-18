//
//  ViewController.swift
//  ListDemo
//
//  Created by Jitendra Deore on 18/06/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import UIKit

// This is for storing the json array ..
typealias JSONItem = [String: Any]

class ViewController: UIViewController {
    
    var listItems = [ListItem]()
    var navTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        APIService.fetchData(apiURL: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") {  [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            switch result{
            case .success(let response):
                strongSelf.listItems = response.listItems
                strongSelf.navTitle = response.title
                self?.title = response.title
                
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

