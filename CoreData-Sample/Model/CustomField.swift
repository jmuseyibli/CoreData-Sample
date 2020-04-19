//
//  CustomField.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/12/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import Foundation

struct CustomField: Decodable {
    let id: String
    let type: Int
    let label: String
    let options: [Pair<String, String>]?
}

enum CFOptions: Int {
    case TextField = 1
    case Numeric = 2
    case FloatPoint = 3
    case SelectBox = 4
    case Date = 5
}

