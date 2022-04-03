//
//  SearchRepoService.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

enum Datasource {
    case coreData
    case api
}


protocol SearchRepoByIdServiceProtocol {
    
    func execute(id: Int, datasource: Datasource, handler: @escaping CompletionRepository)
}
