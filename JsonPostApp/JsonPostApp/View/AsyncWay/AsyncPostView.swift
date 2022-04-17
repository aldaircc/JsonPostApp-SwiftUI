//
//  AsyncPostView.swift
//  JsonPostApp
//
//  Created by Aldair Cosetito Coral on 16/04/22.
//

import SwiftUI

struct AsyncPostView: View {
    
    // MARK: - Variable
    @StateObject var asyncPostVM = AsyncPostViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                
                Picker("", selection: .constant(1)) {
                    Text("A")
                    Text("B")
                }
                .pickerStyle(.segmented)
                
                List(asyncPostVM.posts, id: \.id) { post in
                    Text(post.post.title)
                }
            }
        }
        .task {
            await asyncPostVM.getPosts()
        }
    }
}

struct AsyncPostView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncPostView()
    }
}
