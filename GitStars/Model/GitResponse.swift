//
//  ModelGitResponse.swift
//  GitStars
//
//  Created by SP10472 on 29/03/22.
//

import Foundation

// MARK: - GitResponse

struct GitResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let repos: [Repo]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case repos = "items"
    }
}
