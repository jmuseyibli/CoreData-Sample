//
//  Error.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/12/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import Foundation

struct Error: Decodable {
    let code: Int
    let message: String
}

enum ValidationError: Swift.Error {
    case emptyField(String)
}
