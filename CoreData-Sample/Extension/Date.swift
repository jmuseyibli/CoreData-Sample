//
//  Date.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/13/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import Foundation

extension Date {
    
    func stringInDesiredFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
}

extension String {
    func dateInDesiredFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let date = dateFormatter.date(from: self) else { return "" }

        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "hh:mm a, dd MMM yyyy"
        
        return dateFormatter.string(from: date)
    }
}

