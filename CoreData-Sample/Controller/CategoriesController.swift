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
        
        // TODO: Load data
    }

    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

