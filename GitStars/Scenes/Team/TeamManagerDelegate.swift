//
//  RepoViewModelDelegate.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

protocol TeamManagerDelegate: AnyObject {
    func fetchTeamWithSuccess()
    func errorToFetchTeam(_ error: String)
}
