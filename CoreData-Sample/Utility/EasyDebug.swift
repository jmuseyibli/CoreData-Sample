//
//  EasyDebug.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/15/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import Foundation

class EasyDebug {
    
    static let shared = EasyDebug()
    
    func printCategories() {
        CoreDataManager.shared.fetchCategories().forEach { (categoryModel) in
            print("Category:")
            print("- ID: \(categoryModel.id ?? "Undefined")")
            print("- Name: \(categoryModel.name ?? "Undefined")")
            print("- Providers:")
            guard let providerModels = categoryModel.providers as? Set<ProviderModel> else { return }
            providerModels.forEach { (providerModel) in
                print("   - ID: \(providerModel.id ?? "Undefined")")
                print("   - Name: \(providerModel.name ?? "Undefined")")
                guard let customFieldModels = providerModel.fields as? Set<CustomFieldModel> else { return }
                customFieldModels.forEach { (customFieldInstance) in
                    print("      - ID: \(customFieldInstance.id ?? "Undefined")")
                    print("      - Label: \(customFieldInstance.label ?? "Undefined")")
                    if let fieldOptionInstances = customFieldInstance.options as? Set<PairModel> {
                        fieldOptionInstances.forEach { (optionInstance) in
                            print("         - ID: \(optionInstance.k ?? "Undefined" as NSObject)")
                            print("         - Label: \(optionInstance.v ?? "Undefined" as NSObject)")
                        }
                    }
                }
                
            }
        }
    }
}

