//
//  RepoViewModel.swift
//  GitStars
//
//  Created by Matheus Lenke on 01/04/22.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Variables
    weak var delegate: RepoManagerDelegate?
    private var searchRepoServices: SearchRepoServiceProtocol
    private var total = 0
    private var isFetchInProgress = false
    
    var coordinator: HomeCoordinator?
    
    var gitResponse: GitResponse?
    
    var repositories: [Repo] = []
    
    var currentPage = 1
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
      return repositories.count
    }
    
    var searchLanguage = "swift"
    var searchOrder = "desc"
    
    // MARK: - Initializer
    init(searchRepoServices: SearchRepoServiceProtocol) {
        self.searchRepoServices = searchRepoServices
    }

    // MARK: - Private methods

    private func success(gitResponse: GitResponse) {
        DispatchQueue.main.async {
            self.gitResponse = gitResponse
            self.currentPage += 1
            self.repositories.append(contentsOf: gitResponse.repos)
            self.total = self.repositories.count
            self.isFetchInProgress = false
            if self.currentPage > 1 {
                let indexPathsToReload = self.calculateIndexPathsToReload(from: gitResponse.repos)
                self.delegate?.fetchRepoWithSuccess(with: indexPathsToReload)
            } else {
                self.delegate?.fetchRepoWithSuccess(with: .none)
            }
        }
    }
    
    private func error(error: String) {
        delegate?.errorToFetchRepo(error)
    }
    
    private func calculateIndexPathsToReload(from newRepositories: [Repo]) -> [IndexPath] {
      let startIndex = repositories.count - newRepositories.count
      let endIndex = startIndex + newRepositories.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    // MARK: - Public methods
    
    func fetchRepositories() {
        guard !isFetchInProgress else {
          return
        }
        
        isFetchInProgress = true
        searchRepoServices.execute(language: searchLanguage, order: searchOrder, page: currentPage) { result in
            switch result {
            case .success(let gitResponse):
                self.isFetchInProgress = false
                self.success(gitResponse: gitResponse)
            case .failure(let error):
                self.isFetchInProgress = false
                self.error(error: "Error: \(error.localizedDescription)")
            }
        }
    }
    
    func resetPage() {
        currentPage = 1
        repositories = []
    }
    
}
