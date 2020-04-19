//
//  CoreDataManager.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/12/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataSample")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of the store failed: \(error)")
            }
        }
        return container
    }()
    
    func fetchCategories() -> [CategoryModel] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CategoryModel>(entityName: "CategoryModel")
        do {
            let categories = try context.fetch(fetchRequest)
            return categories
        } catch let fetchError {
            print("Failed to fetch categories: \(fetchError)")
            return []
        }
    }
    
    func batchDeleteCategories(completion: () -> Void) {
        let context = persistentContainer.viewContext
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: CategoryModel.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
            completion()
        } catch let batchDeleteExecutionError {
            print("Failed to batch delete categories: \(batchDeleteExecutionError)")
        }
    }
    
    func addCategorytoCoreData(from category: Category) throws -> CategoryModel? {
        let context = persistentContainer.viewContext

        let categoryInstance = NSEntityDescription.insertNewObject(forEntityName: "CategoryModel", into: context) as? CategoryModel
        categoryInstance?.id = category.id
        categoryInstance?.name = category.name
        category.providers.forEach { (provider) in
            guard let providerInstance = NSEntityDescription.insertNewObject(forEntityName: "ProviderModel", into: context) as? ProviderModel else { return }
            providerInstance.id = provider.id
            providerInstance.name = provider.name
            provider.fields.forEach { (field) in
                guard let fieldInstance = NSEntityDescription.insertNewObject(forEntityName: "CustomFieldModel", into: context) as? CustomFieldModel else { return }
                fieldInstance.id = field.id
                fieldInstance.label = field.label
                fieldInstance.type = Int32(field.type)
                if field.type == 4 {
                    guard let options = field.options else { return }
                    options.forEach { (pair) in
                        guard let option = NSEntityDescription.insertNewObject(forEntityName: "PairModel", into: context) as? PairModel else { return }
                        option.k = pair.k as NSObject
                        option.v = pair.v as NSObject
                        fieldInstance.addToOptions(option)
                    }
                }
                providerInstance.addToFields(fieldInstance)
            }
            categoryInstance?.addToProviders(providerInstance)
        }
        
        do {
            try context.save()
            return categoryInstance
        } catch let saveError {
            print("Failed to save the category: \(saveError)")
            throw saveError
        }
    }
    
    func fetchCategoriesAsStruct() -> [Category] {
        var categories = [Category]()
        fetchCategories().forEach { (categoryModel) in
            guard let providerModels = categoryModel.providers as? Set<ProviderModel> else { return }
            var providers = [Provider]()
            providerModels.forEach { (providerModel) in
                guard let customFieldModels = providerModel.fields as? Set<CustomFieldModel> else { return }
                var customFields = [CustomField]()
                customFieldModels.forEach { (customFieldInstance) in
                    var options = [Pair<String, String>]()
                    if let fieldOptionInstances = customFieldInstance.options as? Set<PairModel> {
                        
                        fieldOptionInstances.forEach { (optionInstance) in
                           let option = Pair<String, String>(
                                k: optionInstance.k as? String ?? "Undefined",
                                v: optionInstance.v as? String ?? "Undefined"
                            )
                            options.append(option)
                        }
                    }
                    let customField = CustomField(id: customFieldInstance.id ?? "Undefined", type: Int(customFieldInstance.type), label: customFieldInstance.label ?? "Undefined", options: options)
                    customFields.append(customField)
                    
                }
                let provider = Provider(id: providerModel.id ?? "Undefined", name: providerModel.name ?? "Undefined", fields: customFields)
                providers.append(provider)
            }
            let category = Category(id: categoryModel.id ?? "Undefined", name: categoryModel.name ?? "Undefined", providers: providers)
            categories.append(category)
        }
        return categories
    }

}

