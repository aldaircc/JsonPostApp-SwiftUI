//
//  CommentModel.swift
//  JsonPostApp
//
//  Created by Aldair Cosetito Coral on 17/04/22.
//

import Foundation

struct CommentModel: Codable, Identifiable {
    let postId: Int?
    let id: Int
    let name: String?
    let email: String?
    let body: String?
}
