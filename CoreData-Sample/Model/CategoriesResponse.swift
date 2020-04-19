//
//  PaymentResponse.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/12/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import Foundation

struct CategoriesResponse: Decodable {
    let error: Error?
    let data: [Category]?
}

