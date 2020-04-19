//
//  PaymentFormController+TableView.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/15/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import UIKit

extension PaymentFormController {
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.addSubview(makePaymentButton)
        makePaymentButton.autoPinEdgesToSuperviewEdges(with: .init(top: 16, left: 16, bottom: 0, right: 16))
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let fieldType = fields[indexPath.item].type
        if fieldType == CFOptions.Date.rawValue {
            return 200
        } else if fieldType == CFOptions.SelectBox.rawValue {
            return 100
        }
        return 48
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! InputCell
        cell.customField = fields[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
}

