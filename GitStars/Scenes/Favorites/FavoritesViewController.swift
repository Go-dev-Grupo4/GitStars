//
//  FavoritesViewController.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 28/03/22.
//

import UIKit

class FavoritesViewController: TriStateViewController {
 
    var viewModel: FavoritesViewModel?
    
    private var state: ViewState = .loading {
        didSet {
            DispatchQueue.main.async {
                self.setupView()
            }
        }
    }

    private func setupView() {
        switch state {
        case .loading:
            print("loading")
            self.setupLoadingState()
        case .normal:
            print("normal")
            self.setupNormalState()
            self.tableView.reloadData()
        case .error:
            print("error")
            setupErrorState()
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        
        setupDelegates()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        state = .loading
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchRepositories()
    }
    
    private func configUI() {
        title = "Favorites"
        view.backgroundColor = .systemBackground
        
        tableView.register(ReusableTableViewCell.self, forCellReuseIdentifier: ReusableTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        
        contentView.addSubview(tableView)
        tableView.sizeUpToFillSuperview()
    }
    
    func fetchRepositories() {
        state = .loading
        viewModel?.fetchRepositories()
    }

    private func setupDelegates() {
        
        tableView.delegate = self
        tableView.dataSource = self
        viewModel?.delegate = self

    }
    
}

extension FavoritesViewController: FavoriteManagerDelegate {
    func fetchRepoWithSuccess() {
        self.state = .normal
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func errorToFetchRepo(_ error: String) {
        self.state = .error
    }
}


extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repositoryDetailsViewController = RepositoryDetailsViewController()
        let repositoryDetailsViewModel = RepositoryDetailsViewModel(searchRepoByIdServices: SearchRepoByIdService())
        repositoryDetailsViewModel.coreDataRepository = viewModel?.repositories?[indexPath.row]
        repositoryDetailsViewController.viewmodel = repositoryDetailsViewModel
        
        navigationController?.pushViewController(repositoryDetailsViewController, animated: true)
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.repositories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusableTableViewCell.identifier, for: indexPath) as? ReusableTableViewCell,
              let repo = viewModel?.repositories?[indexPath.row] else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: "CELL")
        }
        
        cell.setupView(with: repo)
        
        return cell
    }
}
