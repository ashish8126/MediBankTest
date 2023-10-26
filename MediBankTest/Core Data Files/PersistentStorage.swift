//
//  PersistentStorage.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 25/10/23.
//

import UIKit
import CoreData

final class PersistentStorage
{

    private init(){}
    static let shared = PersistentStorage()

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "MediBankTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context = persistentContainer.viewContext
    // MARK: - Core Data Saving support

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]?
    {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else {return nil

            }

            return result

        } catch let error {
            debugPrint(error)
        }

        return nil
    }

    func printDocumentDirectoryPath() {
       debugPrint(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
    }
    
    func saveData(name: String,
                  description: String,
                  isSaved: Bool,
                  isSelected: Bool,
                  imageURL: String,
                  articleURL: String,
                  content: String,
                  sourceName: String,
                  sourceId: String,
                  author: String, privateManagedContext: NSManagedObjectContext) {
            let articleEntity = ArticleEntity(context: privateManagedContext)
            articleEntity.id = UUID()
            articleEntity.name = name
            articleEntity.articleDescription = description
            articleEntity.imageURL = imageURL
            articleEntity.articleURL = articleURL
            articleEntity.author = author
            articleEntity.sourceName = sourceName
            articleEntity.content = content
            articleEntity.isSaved = isSaved
            articleEntity.isSelected = isSelected
            articleEntity.sourceId = sourceId
    }
    
    func getData() -> [ArticleEntity]? {
        let result = self.fetchManagedObject(managedObject: ArticleEntity.self)
        return result
    }
    
    func deleteData(data: ArticleEntity) -> Bool {
        if getArticleData(byIdentifier: data.id ?? UUID()) != nil {
            self.context.delete(data)
            if context.hasChanges {
                try? self.context.save()
                return true
            }
            return false
        }
        return false
    }
    
    func updateData(byId uuid: UUID, isSelected: Bool) -> Bool {
        let result = getArticleData(byIdentifier: uuid)
        guard result != nil else {
            return false
        }
        result?.isSelected = isSelected
        self.saveContext()
        return true
    }
    
    func getArticleData(byIdentifier id: UUID) -> ArticleEntity? {
        
        let fetchRequest = NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            let result = try self.context.fetch(fetchRequest).first
            
            guard result != nil else { return nil }
            
            return result
            
        } catch let err {
            debugPrint(err)
        }
        
        return nil
        
    }
    
}
