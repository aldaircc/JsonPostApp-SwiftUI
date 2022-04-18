//
//  WebService.swift
//  JsonPostApp
//
//  Created by Aldair Cosetito Coral on 16/04/22.
//

import Foundation

final class WebService {
    
    func getPost(url: URL) async throws -> [PostModel] {
        let (data, _) = try await URLSession.shared.data(from: url)
        let posts = try? JSONDecoder().decode([PostModel].self, from: data)
        return posts ?? []
    }
    
    func getCommentsBy(postId: Int) async throws -> [CommentModel] {
        //https://jsonplaceholder.typicode.com/comments?postId=1
        var components = URLComponents(string: "https://jsonplaceholder.typicode.com/comments")
        components?.queryItems = [URLQueryItem.init(name: "postId", value: "\(postId)")]
        
        guard let url = components?.url else {
            throw NetworkError.badURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let comments = try? JSONDecoder().decode([CommentModel].self, from: data)
        
        return comments ?? []
    }
    
    func getCommentsByFromCallBack(postId: Int) async throws -> [CommentModel] {
        
        return try await withCheckedThrowingContinuation({ continuation in
            getCommentsBy(postId: postId) { response in
                switch response {
                case .success(let comments):
                    continuation.resume(returning: comments)
                    
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
    
    private func getCommentsBy(postId: Int, completion: @escaping (Result<[CommentModel], Error>) -> Void ) {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(postId)") else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil  else {
                completion(.failure(NetworkError.badURL))
                return
            }
            
            if let data = data {
                do {
                    let jsonDecoded = try JSONDecoder().decode([CommentModel].self, from: data)
                    completion(.success(jsonDecoded))
                } catch {
                    completion(.failure(NetworkError.errorConverting))
                }
            }
            
        }.resume()
    }
}
