//
//  FavoritesViewModel.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 03/04/22.
//

import Foundation

class FavoritesViewModel {
    
    // MARK: - Variables
    weak var delegate: FavoritesManagerDelegate?
    
    private var search: SearchRepoCoreDataServiceProtocol
    
    var coordinator: FavoritesCoordinator?
    
    var repositories: [FavoritesModel]?
    
    // MARK: - Life Cycle
    
    init(searchRepoServices: SearchRepoCoreDataServiceProtocol) {
        self.search = searchRepoServices
    }
    
    // MARK: - Public functions
    
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
    
    // MARK: - Private functions
    
    private func success(repositories: [FavoritesModel]) {
        self.repositories = repositories
        delegate?.fetchRepoWithSuccess()
    }
    
    private func error(error: String) {
        delegate?.errorToFetchRepo(error)
    }
}
