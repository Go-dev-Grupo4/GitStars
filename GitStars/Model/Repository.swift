//
//  Repository.swift
//  GitStars
//
//  Created by SP11601 on 30/03/22.
//

import Foundation

struct Repository: Codable {
    let id: UUID
    let repoName: String
    let repoDescription: String
    let avatarURL: String
    let isFavorite: Bool
}
