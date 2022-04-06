//
//  SearchRepoService.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import UIKit

internal typealias TeamCompletion = (Result<TeamModel, TeamError>) -> Void

class TeamService: TeamServiceProtocol {
    
    func execute(handler: @escaping TeamCompletion) {
        
        let team = TeamModel(members: DataSource.developers, count: DataSource.developers.count)
        
        handler(.success(team))
    }
}
