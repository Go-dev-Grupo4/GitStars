//
//  ModelAuthor.swift
//  GitStars
//
//  Created by SP10472 on 29/03/22.
//

import Foundation

// MARK: - Author
struct Author: Codable {
    
    let login: String
    let id: Int
    let name: String?
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case name
        case avatarUrl = "avatar_url"
    }
}
