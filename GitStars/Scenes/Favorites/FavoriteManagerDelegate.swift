//
//  RepoViewModelDelegate.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

protocol FavoriteManagerDelegate: AnyObject {
    func fetchRepoWithSuccess()
    func errorToFetchRepo(_ error: String)
}
