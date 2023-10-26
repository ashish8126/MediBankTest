//
//  MockHeadlinesService.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 26/10/23.
//

import Foundation

class MockHeadlinesService {
    
    var result: Result<[Article], CustomError>!
    
    func getArticles() -> ArticlesData? {
        do {
            if let path = Bundle.main.path(forResource: "headlines", ofType: "json") {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl)
                let obj = try JSONDecoder().decode(ArticlesData.self, from: data)
                return obj
            }
        } catch let err {
            print("Error in Reading mock JSON - \(err.localizedDescription)")
        }
        return nil
    }

}
