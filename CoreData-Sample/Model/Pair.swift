//
//  Pair.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/12/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import Foundation

struct Pair<K: Codable, V: Codable>: Codable {
    let k: K
    let v: V
}

