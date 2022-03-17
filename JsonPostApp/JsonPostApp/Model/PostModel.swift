//
//  PostModel.swift
//  JsonPostApp
//
//  Created by Aldair Cosetito Coral on 15/03/22.
//

import Foundation

struct PostModel:Codable, Identifiable {
    let userId:Int
    let id:Int
    let title:String
    let body:String
    var isFavorite:Bool?
    
    mutating func setFavorite(status: Bool) {
        self.isFavorite = status
    }
}
