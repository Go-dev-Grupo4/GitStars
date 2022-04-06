//
//  FavoritesViewModel.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 03/04/22.
//

import UIKit

class TeamViewModel {
    
    weak var delegate: TeamManagerDelegate?
    weak var coordinator: TeamCoordinator?
    var service: TeamService?
    var team: TeamModel?
    
    init(teamServices: TeamService) {
        self.service = teamServices
    }
    
    func fetchTeam() {
        service?.execute() { result in
            switch result {
            case .success(let team):
                self.success(team: team)
            case .failure(let error):
                self.error(error: "Error: \(error.localizedDescription)")
            }
        }
    }
    
    func showDetail(dev: Developer) {
        coordinator?.flowDetail(dev: dev)
    }
    
    private func success(team: TeamModel) {
        self.team = team
        delegate?.fetchTeamWithSuccess()
    }
    
    private func error(error: String) {
        delegate?.errorToFetchTeam(error)
    }
}
