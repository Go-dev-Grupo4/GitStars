//
//  SearchRepoService.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

typealias CompletionRepositories = (Result<[Repository], RepoError>) -> Void

class SearchRepoCoreDataService: SearchRepoCoreDataServiceProtocol {
    
    func execute(handler: @escaping (Result<[Repository], RepoError>) -> Void) {
        
        let repositories = ManagedObjectContext.shared.getRepositories()
        
        handler(.success(repositories))
        
    }
}
