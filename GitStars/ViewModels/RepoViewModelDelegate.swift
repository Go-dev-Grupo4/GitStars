//
//  RepoViewModelDelegate.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

protocol RepoViewModelDelegate: AnyObject {
    func fetchRepoWithSuccess()
    func errorToFetchRepo(_ error: String)
}
