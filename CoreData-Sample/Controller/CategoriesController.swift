//
//  CategoriesController.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/12/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import UIKit

class CategoriesController: UICollectionViewController {
    
    let cellId = "categoriesReuseIdentifier"
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        navigationItem.title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        
        loadData()
    }
    
    fileprivate func loadData() {
        if Connectivity.isConnectedToInternet {
            Service.shared.getCategories(success: { (categories, error)  in
                if let error = error {
                    self.presentAlert(title: "Oops", message: "Request failed with ERR\(error.code): \(error.message)", actionTitle: "Dismiss", actionStyle: .destructive, handler: { (_) in
                        self.dismiss(animated: true, completion: {
                            self.categories = CoreDataManager.shared.fetchCategoriesAsStruct()
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                        })
                    }, completion: nil)
                    return
                }
                guard let categories = categories else { return }
                self.categories = categories
                EasyDebug.shared.printCategories()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }) {
                print("error")
            }
        } else {
            EasyDebug.shared.printCategories()
            presentAlert(title: "No internet connection", message: "Internet connection is not available. We will use cashed payment options.", actionTitle: "Dismiss", actionStyle: .destructive, handler: { (_) in
                self.dismiss(animated: true, completion: nil)
            }) {
                self.categories = CoreDataManager.shared.fetchCategoriesAsStruct()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }

    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

