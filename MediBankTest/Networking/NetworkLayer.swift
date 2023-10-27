//
//  NetworkLayer.swift
//  MediBankTest
//
//  Created by Ashish Viltoriya on 25/10/23.
//

import Foundation
import CoreData

public enum CustomError: Error {
    case invalidURL
    case invalidData
}

extension URLSession {
    
    func request<T: Codable>(url: URL?, 
                             expecting: T.Type,
                             completion: @escaping(Result<T, Error>) -> Void) {
        
        guard let url = url else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        let task = dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch let err {
                completion(.failure(err))
            }
        }
        task.resume()
    }
    
}
