//
//  FavoritesViewController.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 28/03/22.
//

import UIKit

class FavoritesViewController: TriStateViewController {
 
    // MARK: - Variables
    
    var viewModel: FavoritesViewModel?
    
    
    // MARK: - Screen state
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
            self.setupLoadingState()
        case .normal:
            self.setupNormalState()
            self.tableView.reloadData()
        case .error:
            setupErrorState()
        }
    }
    
    // MARK: - UI Components
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        state = .loading

        NotificationCenter.default.addObserver(self, selector: #selector(reloadCallback), name: .reloadCallback, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchRepositories()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .reloadCallback, object: nil)
    }
    
    // MARK: - Private functions
    
    private func configUI() {
        title = NSLocalizedString("favoriteTitle", comment: "")
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
    
    @objc private func reloadCallback() {
        fetchRepositories()
    }
    

}

// MARK: - FavoritesManagerDelegate

extension FavoritesViewController: FavoritesManagerDelegate {
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


// MARK: - UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let repo = viewModel?.repositories?[indexPath.row] {
            viewModel?.coordinator?.repositoryDetail(repo: repo)
        }
    }
}

// MARK: - UITableViewDataSource

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
