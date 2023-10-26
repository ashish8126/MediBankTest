//
//  Constants.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 25/10/23.
//

import Foundation

class Constants {
    
    static let apiKey = "402343cdaa314f2faf2163e8b76a1d5d"
    static let query = "apple"
    static let fromDate = "2023-10-23"
    static let toDate = "2023-10-23"
    static let sort = "popularity"
    static let serverURL = "https://newsapi.org/v2/everything?q=\(query)&from=\(fromDate)&to=\(toDate)&sortBy=\(sort)&apiKey=\(apiKey)"
    
}
