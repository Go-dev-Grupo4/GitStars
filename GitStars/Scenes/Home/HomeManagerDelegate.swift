//
//  RepoViewModelDelegate.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

protocol RepoManagerDelegate: AnyObject {
    func fetchRepoWithSuccess(with newIndexPathsToReload: [IndexPath]?)
    func errorToFetchRepo(_ error: String)
}
