//
//  IndentedLabel.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/14/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import UIKit

class IndentedTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

