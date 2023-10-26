//
//  SourcesListViewModel.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 26/10/23.
//

import Foundation

final class SourcesListViewModel {
    var data: Boxing<[ArticleEntity]> = Boxing([])

    func getStoredData() {
        data.value =  HeadlinesListData.shared.getHeadlines()
    }
    
}
