//
//  PaymentResponse.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/15/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import Foundation

struct PaymentResponse: Decodable {
    let error: Error?
    let data: Receipt?
}

