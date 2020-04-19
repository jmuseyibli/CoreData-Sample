//
//  Receipt.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/12/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import Foundation

struct Receipt: Decodable {
    let id: String
    let date: String
    let details: [Pair<String, String>]
    let amount: Amount
}

