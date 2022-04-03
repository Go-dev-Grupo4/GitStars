//
//  RepositoriesRequest.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

enum HomeRequest : URLRequestProtocol {
    
    case searchAllRepoByLanguage(String)
    case searchRepoById(Int)
    case getUser(String)
    
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
        case .searchAllRepoByLanguage(let language):
            let acceptQueryParam = "accept=application/vnd.github.v3+json"
            let order = "desc"
            let perPage = "30"
            let page = "1"
            return "\(acceptQueryParam)&q=language:\(language)&order=\(order)&perPage=\(perPage)&page=\(page)"
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
