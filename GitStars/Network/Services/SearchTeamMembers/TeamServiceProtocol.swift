//
//  SearchRepositoriesServiceProtocol.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

enum TeamError: Error {
    case error(String)
    case urlInvalid
    case noDataAvailable
    case noProcessData
}

protocol TeamServiceProtocol: AnyObject {
    
    func execute(handler: @escaping(Result<TeamModel, TeamError>) -> Void)
}
