//
//  RepositoryDetailsViewModel.swift
//  GitStars
//
//  Created by Matheus Lenke on 04/04/22.
//

import Foundation

class RepositoryDetailsViewModel {
    
    // MARK: - Variables
    
    weak var delegate: RepositoryDetailsManagerDelegate?
    
    var searchRepoByIdService: SearchRepoByIdService
    
    var coreDataRepository: FavoritesModel?
    
    var apiRepository: Repo?
    
    // MARK: - Life Cycle
    
    init(searchRepoByIdServices: SearchRepoByIdService) {
        self.searchRepoByIdService = searchRepoByIdServices
    }
    
    // MARK: - Public functions
    
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
                if let repoResponse = repoResponse as? FavoritesModel {
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
                    self.coreDataRepository = resultRepo as? FavoritesModel
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
    
    // MARK: - Private functions
    
    private func addFavoriteRepo() {
        if let repo = self.apiRepository {
            let newRepo = FavoritesModel(id: repo.id, repoName: repo.name, repoDescription: repo.repoDescription ?? NSLocalizedString("defaultDescriptionText", comment: ""), avatarURL: repo.author.avatarUrl, isFavorite: true)
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
        }
    }
}
