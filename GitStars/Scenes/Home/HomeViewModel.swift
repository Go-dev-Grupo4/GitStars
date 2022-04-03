//
//  RepoViewModel.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

class HomeViewModel {
    weak var delegate: RepoManagerDelegate?
    
    private var searchRepoServices: SearchRepoServiceProtocol
    
    var gitResponse: GitResponse?
    
    var repositories: [Repo]?
    
    init(searchRepoServices: SearchRepoServiceProtocol) {
        self.searchRepoServices = searchRepoServices
    }
    
    func fetchRepositories(language: String) {
        searchRepoServices.execute(language: language) { result in
            switch result {
            case .success(let gitResponse):
                self.success(gitResponse: gitResponse)
            case .failure(let error):
                self.error(error: "Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func success(gitResponse: GitResponse) {
        self.gitResponse = gitResponse
        self.repositories = gitResponse.repos
        delegate?.fetchRepoWithSuccess()
    }
    
    private func error(error: String) {
        delegate?.errorToFetchRepo(error)
    }
}
