//
//  HeadingListViewModel.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 25/10/23.
//

import Foundation

protocol NetworkData {
    func getDataFromServer()
}

final class HeadingListViewModel: NetworkData {
    var articleData: Boxing<[ArticleEntity]> = Boxing([])
    var isDataSaved: Boxing<Bool> = Boxing(false)
    var updatedData = [ArticleEntity]()
    let url = URL(string: Constants.serverURL)
    
    func getDataFromServer() {
        guard let url = URL(string: Constants.serverURL) else {
            return
        }
        URLSession.shared.request(url: url, expecting: ArticlesData.self) { result in
            switch result {
            case .success(let articleData):
                PersistentStorage.shared.persistentContainer.performBackgroundTask { context in
                    for article in articleData.articles {
                        PersistentStorage.shared.saveData(name: article.title, description: article.description, isSaved: false, isSelected: false, imageURL: article.urlToImage ?? "", articleURL: article.url, content: article.content, sourceName: article.source.name, sourceId: article.source.id ?? "" ,author: article.author ?? "", privateManagedContext: context)
                        
                    }
                    if context.hasChanges {
                        try? context.save()
                        self.isDataSaved.value = true
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getData() {
        if let storedArticles = PersistentStorage.shared.getData() {
            self.articleData.value = storedArticles
            HeadlinesListData.shared.setHeadlines(data: storedArticles)
        }
        
    }
    
    func getSelectedArticles(list: [String], shouldUpdateList: Bool) {
        if shouldUpdateList && list.count > 0 {
            if let data = PersistentStorage.shared.getData() {
                self.updatedData.removeAll()
                for item in list {
                    let filteredData = data.filter({ $0.sourceName?.lowercased() == item.lowercased() })
                    self.updatedData.append(contentsOf: filteredData)
                }
                self.articleData.value.removeAll()
                self.articleData.value = updatedData
                
            }
        } else {
            self.getData()
        }
    }
    
}
