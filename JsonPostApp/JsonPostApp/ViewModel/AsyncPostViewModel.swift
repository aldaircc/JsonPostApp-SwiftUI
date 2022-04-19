//
//  AsyncPostViewModel.swift
//  JsonPostApp
//
//  Created by Aldair Cosetito Coral on 16/04/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case errorConverting
}

@MainActor
class AsyncPostViewModel: ObservableObject {

    // MARK: - Properties
    @Published var posts: [PostItemViewModel] = []
    @Published var comments: [CommentItemViewModel] = []
    
    // MARK: - Methods
    func getPosts() async {
        do {
            WebService().consumeTermnsAndConditions()
            /*:
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
                throw NetworkError.badURL
            }
            
            let posts = try await WebService().getPost(url: url)
            self.posts = posts.map(PostItemViewModel.init)
            */
        } catch {
            print(error)
        }
    }
    
    func getCommentBy(postId: Int) async {
        do {
            let comments = try await WebService().getCommentsBy(postId: postId)
            self.comments = comments.map(CommentItemViewModel.init)
        /*: Using continuation to consume callback method and call it from async function
         let comments = try await WebService().getCommentsByFromCallBack(postId: postId)
         self.comments = comments.map(CommentItemViewModel.init)
         */
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

struct CommentItemViewModel: Identifiable {
    let comment: CommentModel
    
    var id: Int {
        comment.id
    }
}
