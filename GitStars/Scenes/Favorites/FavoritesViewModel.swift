//
//  FavoritesViewModel.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 03/04/22.
//

import Foundation

class FavoritesViewModel {
    weak var delegate: FavoriteManagerDelegate?
    
    private var search: SearchRepoCoreDataServiceProtocol
    
    var coordinator: FavoritesCoordinator?
    
    var repositories: [Repository]?
    
    init(searchRepoServices: SearchRepoCoreDataServiceProtocol) {
        self.search = searchRepoServices
    }
    
    func fetchRepositories() {
        search.execute() { result in
            switch result {
            case .success(let repositories):
                self.success(repositories: repositories)
            case .failure(let error):
                self.error(error: "Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func success(repositories: [Repository]) {
        self.repositories = repositories
        delegate?.fetchRepoWithSuccess()
    }
    
    private func error(error: String) {
        delegate?.errorToFetchRepo(error)
    }
}
