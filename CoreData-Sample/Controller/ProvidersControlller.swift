//
//  ProvidersController.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/13/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import UIKit

class ProvidersController: UITableViewController {
    
    let cellId = "providersReuseIdentifier"
    
    var category: Category? {
        didSet {
            self.providers = category?.providers ?? []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var providers = [Provider]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Providers"
        tableView.tableFooterView = UIView()
        
        tableView.register(ProviderCell.self, forCellReuseIdentifier: cellId)
    }
    
}
