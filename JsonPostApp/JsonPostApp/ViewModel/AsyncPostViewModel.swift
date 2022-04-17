//
//  AsyncPostViewModel.swift
//  JsonPostApp
//
//  Created by Aldair Cosetito Coral on 16/04/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
}

@MainActor
class AsyncPostViewModel: ObservableObject {

    // MARK: - Properties
    @Published var posts: [PostItemViewModel] = []
    
    // MARK: - Methods
    func getPosts() async {
        do {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
                throw NetworkError.badURL
            }
            
            let posts = try await WebService().getPost(url: url)
            self.posts = posts.map(PostItemViewModel.init)
            
        } catch {
            print(error)
        }
    }
    
}

struct PostItemViewModel: Identifiable {
    let post: PostModel
    
    var id: Int {
        post.id
    }
}
