//
//  URLRequestProtocol.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

protocol URLRequestProtocol {
    
    var baseURL: String { get }
    
    var path: String { get }
    
    var queryParams: String { get }
    
    var method: HTTPMethod { get }
}

