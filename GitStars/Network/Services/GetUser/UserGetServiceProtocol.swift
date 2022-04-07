//
//  SearchUserServiceProtocol.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

enum UserError: Error {
    case error(String)
    case urlInvalid
    case noDataAvailable
    case noProcessData
}

protocol UserGetServiceProtocol: AnyObject {
    
    func execute(login: String, handler: @escaping(Result<Author, UserError>) -> Void)
}
