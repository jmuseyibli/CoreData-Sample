//
//  Provider.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/12/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import Foundation

struct Provider: Decodable {
    let id: String
    let name: String
    let fields: [CustomField]
}

