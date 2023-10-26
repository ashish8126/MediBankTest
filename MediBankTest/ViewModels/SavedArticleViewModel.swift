//
//  SavedArticleViewModel.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 25/10/23.
//

import Foundation

final class SavedArticleViewModel {
    
    var savedArticles: Boxing<[ArticleEntity]> = Boxing([])
    
    func getSavedArticles() {
        if let data = PersistentStorage.shared.getData() {
            savedArticles.value = data.filter({
                $0.isSaved == true
            })
        }
    }
    
    func deleteSavedArticle(article: ArticleEntity) {
        let isDeletedSuccessfully = PersistentStorage.shared.deleteData(data: article)
        if isDeletedSuccessfully {
            getSavedArticles()
        }
        
    }
    
}
