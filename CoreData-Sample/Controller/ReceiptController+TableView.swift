//
//  ReceiptController+TableView.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/15/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import UIKit

extension ReceiptController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receipt?.details.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DetailCell
        cell.detail = receipt?.details[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
}

