//
//  ViewController.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 28/03/22.
//

import UIKit
import SwiftUI

class HomeViewController: TriStateViewController {
    
    // MARK: - Public variables
    
    var safeArea: UILayoutGuide!
    var toogle = true
        
    var viewModel: HomeViewModel?
    
    // MARK: - Private Variables
    
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
        case .error:
            setupErrorState()
        }
    }
    
    // MARK: - UI Components

    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.scopeButtonTitles = [
            NSLocalizedString("ascendingTitle", comment: ""),
            NSLocalizedString("descendingTitle", comment: "")]
        searchController.searchBar.selectedScopeButtonIndex = 1
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsScopeBar = false
        searchController.definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .label
        
        return searchController
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        safeArea = view.layoutMarginsGuide
        
        configUI()
        setupDelegates()
        fetchRepositories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCallback), name: .reloadCallback, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .reloadCallback, object: nil)
    }
    
    // MARK: - Private Functions
    
    private func configUI() {
        title = NSLocalizedString("homeTitle", comment: "")
        
        navigationController?.title = NSLocalizedString("homeTabBarTitle", comment: "")
        view.backgroundColor = .systemBackground
        
        configNavigationBar()
        configSearchBar()
        configTableView()
    }
    
    private func configNavigationBar() {
        let barButtonImage = UIImage(systemName: "slider.horizontal.3")
        let barButtonItem = UIBarButtonItem(image: barButtonImage, style: .plain, target: self, action: #selector(changeSortOrder))
        
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.rightBarButtonItem?.tintColor = Colors.tintTabBarItem
        navigationController?.navigationBar.topItem?.hidesSearchBarWhenScrolling = false
        
        let apearence = UINavigationBarAppearance()
        apearence.shadowColor = UIColor.clear
    }
    
    private func configSearchBar() {
        self.navigationItem.searchController = searchController
    }
    
    private func configTableView() {
        tableView.register(ReusableTableViewCell.self, forCellReuseIdentifier: ReusableTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        
        contentView.addSubview(tableView)
        tableView.sizeUpToFillSuperview()
    }
    
    private func setupDelegates() {
        
        searchController.searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        viewModel?.delegate = self
        
    }
    
    // MARK: - Button Targets
    
    @objc private func changeSortOrder() {
        
        if toogle {
            
            searchController.searchBar.setShowsScope(true, animated: true)
            navigationController?.navigationBar.sizeToFit()
            
        } else {
            searchController.searchBar.setShowsScope(false, animated: true)
            navigationController?.navigationBar.sizeToFit()
            
        }
        toogle = !toogle
    }
    
    @objc private func reloadCallback() {
        fetchRepositories()
    }
    
    @objc private func fetchRepositories() {
        state = .loading
        viewModel?.fetchRepositories()
    }

}

// MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.searchTextField.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let language = searchBar.searchTextField.text {
            viewModel?.searchLanguage = language
            viewModel?.resetPage()
            fetchRepositories()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if selectedScope == 0 {
            viewModel?.searchOrder = "asc"
        } else {
            viewModel?.searchOrder = "desc"
        }
        viewModel?.resetPage()
        fetchRepositories()
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let repo = viewModel?.repositories[indexPath.row] {
            self.viewModel?.coordinator?.repositoryDetail(repo: repo)
        }
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.currentCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusableTableViewCell.identifier, for: indexPath) as? ReusableTableViewCell else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: "CELL")
        }
        if !isLoadingCell(for: indexPath) {
            if let repo = viewModel?.repositories[indexPath.row] {
                cell.setupView(with: repo)
            }
        }
        return cell
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension HomeViewController: UITableViewDataSourcePrefetching {

  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: isLoadingCell) {
      viewModel?.fetchRepositories()
    }
  }
}

// MARK: - RepoManagerDelegate

extension HomeViewController: RepoManagerDelegate {
    func fetchRepoWithSuccess(with newIndexPathsToReload: [IndexPath]?) {
        self.state = .normal
        tableView.reloadData()
    }
    
    func errorToFetchRepo(_ error: String) {
        self.state = .error
    }
}

// MARK: - Infinite scroll methods

extension HomeViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= (viewModel?.currentCount ?? 2) - 2
    }

    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
