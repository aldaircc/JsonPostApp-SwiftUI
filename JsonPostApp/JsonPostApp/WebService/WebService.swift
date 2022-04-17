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
}
