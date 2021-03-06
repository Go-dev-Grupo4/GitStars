//
//  RepositoriesRequest.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

enum Request: URLRequestProtocol {
    
    case searchAllRepoByLanguage(language: String, page: Int, order: String)
    case searchRepoById(id: Int)
    case getUser(login: String)
    
    /// The API's base url
    var baseURL: String {
        return Environment.baseURL
    }
    
    /// Defines the endpoint we want to hit
    var path: String {
        switch self {
        case .searchAllRepoByLanguage:
            return "search/repositories"
        case .searchRepoById:
            return "repositories"
        case .getUser(let user):
            return "users/\(user)"
        }
    }
    
    /// The API's query params
    var queryParams: String {
        switch self {
        case .searchAllRepoByLanguage(let language, let page, let order):
            let acceptQueryParam = "accept=application/vnd.github.v3+json"
            let perPage = "30"
            let sort = "stars"
            return "\(acceptQueryParam)&q=language:\(language)&order=\(order)&perPage=\(perPage)&page=\(page)&sort=\(sort)"
        case .searchRepoById:
            return ""
        case .getUser:
            return ""
        }
    }
    
    /// Relative to the method we want to call, that was defined with an enum above
    var method: HTTPMethod {
        switch self {
        case .searchAllRepoByLanguage:
            fallthrough
        case .searchRepoById:
            fallthrough
        case .getUser:
            return .get
        }
    }
    
}
