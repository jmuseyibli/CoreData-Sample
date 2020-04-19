//
//  Category.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/12/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import Foundation

struct Category: Decodable {
    let id: String
    let name: String
    let providers: [Provider]
}

