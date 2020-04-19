//
//  PaymentRequest.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/12/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import Foundation

struct PaymentRequest: Encodable {
    let providerId: String
    let fields: [Pair<String, String>]
    let amount: Amount
    let card: Card
}

