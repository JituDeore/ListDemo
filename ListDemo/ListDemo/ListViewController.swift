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

class ListViewController: UIViewController {
    
    weak var progressView: UIActivityIndicatorView?
    
    @IBOutlet weak var tableView: UITableView!
    
    var listItems = [ListItem]()
    var navTitle: String!
    
    
    private lazy var refreshControl: UIRefreshControl = { [unowned self] in
        let _refreshControl = UIRefreshControl()
        _refreshControl.addTarget(self, action: #selector(startRefreshing), for: .valueChanged)
        return _refreshControl
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = refreshControl

    
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchListData()
    }
    
    func fetchListData() {
        
        
        showProgress()
        APIService.fetchData(apiURL: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") {  [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.hideProgress()
            strongSelf.refreshControl.endRefreshing()
            switch result{
            case .success(let response):
                strongSelf.listItems = response.listItems
                strongSelf.navTitle = response.title
                self?.title = response.title
                self?.tableView.reloadData()
                
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
    
    @objc func startRefreshing() {
        refreshControl.beginRefreshing()
       fetchListData()
    }
}

extension ListViewController : UITableViewDataSource , UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.displayData(with: listItems[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}


