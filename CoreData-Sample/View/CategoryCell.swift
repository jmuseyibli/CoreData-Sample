//
//  CategoryCell.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/13/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import UIKit
import PureLayout

class CategoryCell: UICollectionViewCell {
    
    var category: Category? {
        didSet {
            categoryLabel.text = category?.name
        }
    }
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font =  .boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        
        layer.cornerRadius = 16
        layer.masksToBounds = true
        
        addSubview(categoryLabel)
        categoryLabel.autoCenterInSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

