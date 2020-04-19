//
//  ReceiptController.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/14/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import UIKit
import PureLayout

class ReceiptController: UIViewController {
    
    let cellId = "detailCellReuseIdentifier"
    
    var receipt: Receipt? {
        didSet {
            guard let receipt = receipt else { return }
            receiptLabel.text =  "Receipt #\(receipt.id)"
            let date = receipt.date.dateInDesiredFormat()
            let attributedString = NSMutableAttributedString(string: "You have successfully made payment \n\n", attributes:  [.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.systemGreen])
            attributedString.append(NSAttributedString(string: "💷 In amount: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)]))
            attributedString.append(NSAttributedString(string: "\(receipt.amount.value) \(receipt.amount.currency) \n\n"))
            attributedString.append(NSAttributedString(string: "🕔 At: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)]))
            attributedString.append(NSAttributedString(string: "\(date)"))
            paymentMessageLabel.attributedText = attributedString
        }
    }
    
    let receiptLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let paymentMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "success")
        return imageView
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Details"
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()
    
    let detailsTableView: UITableView = {
        let tablewView = UITableView()
        return tablewView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(DetailCell.self, forCellReuseIdentifier: cellId)
        detailsTableView.separatorStyle = .none
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
        
        view.backgroundColor = .white
        
        view.addSubview(receiptLabel)
        receiptLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 16)
        receiptLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 16)
        receiptLabel.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -16)
        receiptLabel.autoSetDimension(.height, toSize: 24)
        
        view.addSubview(imageView)
        imageView.autoPinEdge(.top, to: .bottom, of: receiptLabel, withOffset: 24)
        imageView.autoSetDimension(.width, toSize: view.frame.width / 2)
        imageView.autoSetDimension(.height, toSize: view.frame.width / 2)
        imageView.autoAlignAxis(toSuperviewAxis: .vertical)
        
        view.addSubview(paymentMessageLabel)
        paymentMessageLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 16)
        paymentMessageLabel.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -16)
        paymentMessageLabel.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 12)
        
        view.addSubview(detailsLabel)
        detailsLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 16)
        detailsLabel.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -16)
        detailsLabel.autoPinEdge(.top, to: .bottom, of: paymentMessageLabel, withOffset: 32)
        detailsLabel.autoSetDimension(.height, toSize: 20)
        
        view.addSubview(detailsTableView)
        detailsTableView.autoPinEdge(.top, to: .bottom, of: detailsLabel, withOffset: 4)
        detailsTableView.autoPinEdge(.leading, to: .leading, of: view, withOffset: 16)
        detailsTableView.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -16)
        detailsTableView.autoPinEdge(.bottom, to: .bottom, of: view, withOffset: -16)
        
    }
    
    @objc func handleDone() {
        dismiss(animated: true) {
            guard let keyWindow = UIApplication.shared.windows.first(where: { (window) -> Bool in
                return window.isKeyWindow
            }) else { return }
            keyWindow.rootViewController = UINavigationController(rootViewController: CategoriesController())
        }
    }
    
}

