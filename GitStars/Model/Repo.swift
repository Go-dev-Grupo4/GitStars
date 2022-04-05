//
//  ModelRepo.swift
//  GitStars
//
//  Created by SP10472 on 29/03/22.
//

import Foundation

struct Repo: Codable {
    let id: Int
    let name: String
    let author: Author
    let repoDescription: String?
    let url: String
    let createdAt: String
    let license: License?
    let watchers: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case author = "owner"
        case repoDescription = "description"
        case url = "html_url"
        case createdAt = "created_at"
        case license, watchers
    }
}
