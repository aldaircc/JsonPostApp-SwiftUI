//
//  NetworkPersistence.swift
//  JsonPostApp
//
//  Created by Aldair Cosetito Coral on 27/04/22.
//

import Foundation

extension URL {
    static let jsonPostPROD = URL(string: "https://jsonplaceholder.typicode.com/posts")!
}

enum NetworkPersistenceError: Error {
    case badUrl
    case httpError(Int)
    case json(Error)
}

final class NetworkPersistence {
    
    static let shared = NetworkPersistence()
    
    func call<T:Codable>(url: URL, type: T.Type, completion: @escaping (Result<T, NetworkPersistenceError>) -> Void ) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                completion(.failure(.badUrl))
                return
            }
            
            if response.statusCode == 200 {
                do {
                    let objectDecoded = try JSONDecoder().decode(type.self, from: data)
                    completion(.success(objectDecoded))
                } catch {
                    completion(.failure(.json(error)))
                }
            } else {
                completion(.failure(.httpError(response.statusCode)))
                return
            }
            
        }.resume()
    }
}
