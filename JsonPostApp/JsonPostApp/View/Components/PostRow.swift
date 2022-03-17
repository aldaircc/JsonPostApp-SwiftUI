//
//  PostRow.swift
//  JsonPostApp
//
//  Created by Aldair Cosetito Coral on 16/03/22.
//

import Foundation
import SwiftUI

struct PostRow: View {
    // MARK: - Properties
    let post:PostModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 10, height: 10)
                .foregroundColor(.blue)
            Text(post.title)
        }
    }
}

struct PostRow_Preview: PreviewProvider {
    static var previews: some View {
        PostRow(post: PostModel(userId: 1, id: 1, title: "Example", body: "This a description."))
    }
}
