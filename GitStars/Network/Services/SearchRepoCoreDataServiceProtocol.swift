//
//  SearchRepositoriesServiceProtocol.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

protocol SearchRepoCoreDataServiceProtocol: AnyObject {
    
    func execute(handler: @escaping(Result<[Repository], RepoError>) -> Void)
}
