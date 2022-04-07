//
//  RepositoryDetailsManagerDelegate.swift
//  GitStars
//
//  Created by Matheus Lenke on 04/04/22.
//

import Foundation

protocol RepositoryDetailsManagerDelegate: AnyObject {
    func fetchRepoWithSuccessApi()
    func errorToFetchRepoApi(_ error: String)
    
    func fetchRepoWithSuccessCoreData()
    func errorToFetchRepoCoreData(_ error: String)
    
    func favoritedRepoSuccess()
    func favoritedRepoError(_ error: String)
    
    func unfavoritedRepoSuccess()
    func unfavoritedRepoError(_ error: String)
}
