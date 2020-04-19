//
//  PaymentFormController.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/13/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import UIKit

class PaymentFormController: UITableViewController {
    
    let cellId = "paymentFormReuseIdentifier"
    
    let makePaymentButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitle("Make payment", for: .normal)
        button.addTarget(self, action: #selector(handleMakePayment), for: .touchUpInside)
        return button
    }()
    
    var fields = [CustomField]()
    
    let defaultFields: [CustomField] = [
        CustomField(id: "currency", type: CFOptions.SelectBox.rawValue, label: "Currency", options: [
            Pair<String, String>(k: "USD", v: "United States Dollars"),
            Pair<String, String>(k: "USD", v: "Azerbaijan Manat")
        ]),
        CustomField(id: "amount", type: CFOptions.FloatPoint.rawValue, label: "Amount", options: nil),
        CustomField(id: "cardNo", type: CFOptions.Numeric.rawValue, label: "Card Number", options: nil),
        CustomField(id: "exp_month", type: CFOptions.FloatPoint.rawValue, label: "Expiry Month", options: nil),
        CustomField(id: "exp_year", type: CFOptions.FloatPoint.rawValue, label: "Expiry Year", options: nil),
        CustomField(id: "cvv", type: CFOptions.FloatPoint.rawValue, label: "CVV", options: nil),
        
    ]
    
    var provider: Provider? {
        didSet {
            let customFields = provider?.fields ?? []
            self.fields = customFields + defaultFields
            tableView.reloadData()
        }
    }
    
    var fieldValues = [Pair<String, String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = provider?.name
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        
        tableView.register(InputCell.self, forCellReuseIdentifier: cellId)
    }
    
    fileprivate func processFields() throws -> (Amount, Card)? {
        fieldValues = []
        var currency: String?
        var amount: String?
        var cardNo: String?
        var exp_month: String?
        var exp_year: String?
        var cvv: String?
        var hadEmptyValue = false
        
        (0..<fields.count).forEach { (row) in
            guard let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? InputCell else { return }
            let key = fields[row].id
            guard let value = cell.selectedValue else { return }
            
            if value != "" {
                cell.textField.layer.borderColor = UIColor.lightGray.cgColor
            } else {
                hadEmptyValue = true
                cell.textField.layer.borderColor = UIColor.red.cgColor
            }
            
            switch key {
            case "currency":
                currency = value
            case "amount":
                amount = value
            case "cardNo":
                cardNo = value
            case "exp_month":
                exp_month = value
            case "exp_year":
                exp_year = value
            case "cvv":
                cvv = value
            default:
                fieldValues.append(Pair<String, String>(k: key, v: value))
            }
            
        }
        
        if hadEmptyValue {
            throw ValidationError.emptyField("Form includes an empty field")
        }
        
        guard let currencyUnwrapped = currency, let amountUnwrapped = amount, let cardNoUnwrapped = cardNo, let exp_monthUnwrapped = exp_month, let exp_yearUnwrapped = exp_year, let cvvUnwrapped = cvv else { return nil }
        
        let amountInstance = Amount(value: amountUnwrapped, currency: currencyUnwrapped)
        let cardInstance = Card(number: cardNoUnwrapped, exp_month: exp_monthUnwrapped, exp_year: exp_yearUnwrapped, cvv: cvvUnwrapped)
        
        return (amountInstance, cardInstance)
    }
    
    fileprivate func presentReceipt(for receipt: Receipt) {
        // TODO: Present Receipt to user
    }
    
    @objc func handleMakePayment() {
        guard let provider = provider else { return }
        do {
            let cardAmountTuple = try processFields()
            guard let card = cardAmountTuple?.1 else { return }
            guard let amount = cardAmountTuple?.0 else { return }
            let paymentRequest = PaymentRequest(providerId: provider.id, fields: fieldValues, amount: amount, card: card)
            print(paymentRequest)
            if Connectivity.isConnectedToInternet {
                Service.shared.makePayment(paymentRequest: paymentRequest, success: { (receipt, error)  in
                    if let error = error {
                        self.presentAlert(title: "Payment failed", message: "Request failed with ERR\(error.code): \(error.message)", actionTitle: "Dismiss", actionStyle: .default, handler: { (_) in
                            self.dismiss(animated: true, completion: nil)
                        }, completion: nil)
                        return
                    }
                    guard let receipt = receipt else { return }
                    self.presentReceipt(for: receipt)
                }) {
                    self.presentAlert(title: "Payment failed", message: "Failed to make the payment", actionTitle: "Dismiss", actionStyle: .cancel, handler: { (_) in
                        self.dismiss(animated: true, completion: nil)
                    }, completion: nil)
                }
            } else {
                presentAlert(title: "No internet connection", message: "Internet connection is not available. Please check your connection and try again later.", actionTitle: "Dismiss", actionStyle: .destructive, handler: { (_) in
                    self.dismiss(animated: true, completion: nil)
                }, completion: nil)
            }
        } catch let error {
            print("Error: \(error)")
        }
        
    }
    
}

