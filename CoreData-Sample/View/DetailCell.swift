//
//  DetailCell.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/14/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import UIKit
import PureLayout

class DetailCell: UITableViewCell {
    
    let keyLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let valueLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    var detail: Pair<String, String>? {
        didSet {
            keyLabel.text = detail?.k
            valueLabel.text = detail?.v
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(keyLabel)
        keyLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 0)
        keyLabel.autoPinEdge(.top, to: .top, of: self, withOffset: 4)
        keyLabel.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 4)
        keyLabel.autoSetDimension(.width, toSize: self.frame.width / 3)
        
        addSubview(valueLabel)
        valueLabel.autoPinEdge(.leading, to: .trailing, of: keyLabel, withOffset: 16)
        valueLabel.autoPinEdge(.top, to: .top, of: self, withOffset: 4)
        valueLabel.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 4)
        valueLabel.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: 0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
