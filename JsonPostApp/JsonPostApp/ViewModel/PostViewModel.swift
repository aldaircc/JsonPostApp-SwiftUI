//
//  PostViewModel.swift
//  JsonPostApp
//
//  Created by Aldair Cosetito Coral on 15/03/22.
//

import Foundation

final class PostViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var posts:[PostModel] = []
    
    // MARK: - Methods
    func loadPosts() {
        guard let url = Bundle.main.url(forResource: "posts", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return
        }
        
        do {
            let result = try JSONDecoder().decode([PostModel].self, from: data)
            self.posts = result
        } catch {
            print("Error \(error)")
        }
    }
    
    func getPost() -> [PostModel]? {
        guard let url = Bundle.main.url(forResource: "posts", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        do {
            let result = try JSONDecoder().decode([PostModel].self, from: data)
            return result
        } catch {
            print("Error \(error)")
            return nil
        }
    }
}
