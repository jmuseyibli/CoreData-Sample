//
//  Service.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/12/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import Foundation
import CoreData
import Alamofire


class Service {
    
    let baseAPIURL = "https://homeworkkb.jmuseyibli.com"
    
    static let shared = Service()
    
    func getCategories(success: @escaping ([Category]?, Error?) -> (), failure: @escaping () -> ()) {
        
        let urlString = "\(baseAPIURL)/payment/categories"
        AF.request(urlString, method: .get).responseData { (response) in
            switch response.result {
            case .success:
                guard let data =  response.data else { return }
                do {
                    let categoriesResponse = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                    
                    if let error = categoriesResponse.error {
                        success(nil, error)
                    }
                    
                    guard let categories = categoriesResponse.data else { return }
                    CoreDataManager.shared.batchDeleteCategories {}
                    categories.forEach({ (category) in
                        do {
                            let _ = try CoreDataManager.shared.addCategorytoCoreData(from: category)
                        } catch let error {
                            print("Failed to save the fetched categories to Core Data: \(error)")
                        }
                    })
                    success(categories, nil)
                } catch let error {
                    print("Failed to decode the JSON from categories response: \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func makePayment(paymentRequest: PaymentRequest ,success: @escaping (Receipt?, Error?) -> (), failire: @escaping () -> ()) {
        let urlString = "\(baseAPIURL)/payment/new"
        AF.request(urlString, method: .post, parameters: paymentRequest, encoder: JSONParameterEncoder.default).responseData { (response) in
            switch response.result {
            case .success:
                
                guard let data =  response.data else { return }
                do {
                    let receiptResponse = try JSONDecoder().decode(PaymentResponse.self, from: data)
                    if let error = receiptResponse.error {
                        success(nil, error)
                    }
                    guard let receipt = receiptResponse.data else { return }
                    success(receipt, nil)
                } catch let error {
                    print("Failed to decode the JSON from receipt response: \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

