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

/// ViewController to display the list of items.
class ListViewController: UIViewController {
    
    var errView: ErrorView?
    weak var progressView: UIActivityIndicatorView?
    
    @IBOutlet weak var tableView: UITableView!
    
    var listItems = [ListItem]()
    var navTitle: String!

    
    
    /// Lazy instantiation of refersh control
    private lazy var refreshControl: UIRefreshControl = { [unowned self] in
        let _refreshControl = UIRefreshControl()
        _refreshControl.addTarget(self, action: #selector(startRefreshing), for: .valueChanged)
        return _refreshControl
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchListData()
    }
    
    /// Method to fetch list data
    func fetchListData() {
        showProgress()
        APIService.fetchData(apiURL: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") {  [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.hideProgress()
            strongSelf.refreshControl.endRefreshing()
            strongSelf.removeErrorView()
            switch result{
            case .success(let response):
                strongSelf.listItems = response.listItems
                strongSelf.navTitle = response.title
                strongSelf.title = response.title
                strongSelf.tableView.reloadData()
                break
            case .failure(let error):
                self?.handlePageError(error)
                break
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Method to fetch list data on pull to refresh.
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



