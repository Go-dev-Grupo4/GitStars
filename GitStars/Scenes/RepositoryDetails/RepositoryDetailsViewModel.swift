//
//  RepositoryDetailsViewModel.swift
//  GitStars
//
//  Created by Matheus Lenke on 04/04/22.
//

import Foundation

class RepositoryDetailsViewModel {
    
    weak var delegate: RepositoryDetailsManagerDelegate?
    
    var searchRepoByIdService: SearchRepoByIdService
    
    var coreDataRepository: Repository?
    
    var apiRepository: Repo?
    
    
    init(searchRepoByIdServices: SearchRepoByIdService) {
        self.searchRepoByIdService = searchRepoByIdServices
    }
    
    func fetchRepositoryApi() {
        guard let coreDataRepository = coreDataRepository else {
            self.errorApi(error: "Repository not found")
            return
        }
        
        searchRepoByIdService.execute(id: coreDataRepository.id, datasource: .api) { result in
            switch result {
            case .success(let repoResponse):
                if let repoResponse = repoResponse as? Repo {
                    self.successApi(repo: repoResponse)
                }
            case .failure(let error):
                self.errorApi(error: "Error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchRepositoryCoreData() {
        guard let apiRepository = apiRepository else {
            self.errorApi(error: "Repository not found")
            return
        }
        
        searchRepoByIdService.execute(id: apiRepository.id, datasource: .coreData) { result in
            switch result {
            case .success(let repoResponse):
                if let repoResponse = repoResponse as? Repository {
                    self.successCoreData(repo: repoResponse)
                }
            case .failure(let error):
                self.errorCoreData(error: "Error: \(error.localizedDescription)")
            }
        }
    }
    
    func changeRepositoryFavoriteStatus() {
        if let repo = apiRepository {
            searchRepoByIdService.execute(id: repo.id, datasource: .coreData) { result in
                switch result {
                case .success(let resultRepo):
                    self.coreDataRepository = resultRepo as? Repository
                    self.removeFavoriteRepo()
                case .failure(let error):
                    switch error {
                    case .noDataAvailable:
                        self.addFavoriteRepo()
                    case .noProcessData:
                        fallthrough
                    case .urlInvalid:
                        print(error)
                    case .error(let errorMessage):
                        print(errorMessage)
                    }
                }
            }
        } else if let repo = coreDataRepository {
            if repo.isFavorite {
                self.removeFavoriteRepo()
            } else {
                self.addFavoriteRepo()
            }
        }
    }
    
    private func addFavoriteRepo() {
        if let repo = self.apiRepository {
            let newRepo = Repository(id: repo.id, repoName: repo.name, repoDescription: repo.repoDescription ?? "No description", avatarURL: repo.author.avatarUrl, isFavorite: true)
            ManagedObjectContext.shared.save(repository: newRepo) { error in
                print(error)
                delegate?.favoritedRepoError(error)
                return
            }
            delegate?.favoritedRepoSuccess()
        } else if let repo = self.coreDataRepository {
            ManagedObjectContext.shared.save(repository: repo) { error in
                print(error)
                delegate?.favoritedRepoError(error)
                return
            }
            delegate?.favoritedRepoSuccess()
        }
    }
    
    private func removeFavoriteRepo() {
        guard let repo = self.coreDataRepository else { return }
        
        ManagedObjectContext.shared.delete(id: repo.id) { error in
            print(error)
            delegate?.unfavoritedRepoError(error)
            return
        }
        delegate?.unfavoritedRepoSuccess()
    }
    
    private func successApi(repo: Repo) {
        self.apiRepository = repo
        delegate?.fetchRepoWithSuccessApi()
    }
    
    private func errorApi(error: String) {
        delegate?.errorToFetchRepoApi(error)
    }
    
    private func successCoreData(repo: Repository) {
        coreDataRepository = repo
        delegate?.fetchRepoWithSuccessCoreData()
    }
    
    private func errorCoreData(error: String) {
        delegate?.errorToFetchRepoCoreData(error)
    }
}
