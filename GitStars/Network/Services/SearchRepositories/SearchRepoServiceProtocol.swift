//
//  SearchRepositoriesServiceProtocol.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

enum RepoError: Error {
    case error(String)
    case urlInvalid
    case noDataAvailable
    case noProcessData
}

protocol SearchRepoServiceProtocol: AnyObject {
    
    func execute(language: String, order: String, page: Int, handler: @escaping(Result<GitResponse, RepoError>) -> Void)
}
