//
//  ViewController.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 28/03/22.
//

import UIKit

class HomeViewController: TriStateViewController {
    
    var safeArea: UILayoutGuide!
    var toogle = true
    var timeoutTimer: Timer?
    var searchLanguage = "swift"
        
    var viewModel: HomeViewModel?
    
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
        case .error:
            print("error")
            setupErrorState()
        }
    }

    lazy var searchController: UISearchController = {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.scopeButtonTitles = ["Ascending", "Descending"]
        searchController.searchBar.selectedScopeButtonIndex = 0
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        safeArea = view.layoutMarginsGuide
        
        configUI()
        setupDelegates()
        
        fetchRepositories(language: searchLanguage)
    }
    
    private func configUI() {
        title = "List"
        view.backgroundColor = .systemBackground
        
        configNavigationBar()
        configSearchBar()
        configTableView()
    }
    
    @objc private func fetchRepositories(language: String) {
        state = .loading
        viewModel?.fetchRepositories(language: language)
    }
    
    @objc func fetchRepositoriesTimeout() {
        timeoutTimer?.invalidate()
        self.state = .error
    }
    
    private func configNavigationBar() {
        let barButtonImage = UIImage(systemName: "slider.horizontal.3")
        let barButtonItem = UIBarButtonItem(image: barButtonImage, style: .plain, target: self, action: #selector(changeSortOrder))
        
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .label
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
        fetchRepositories(language: searchLanguage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCallback), name: .reloadCallback, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .reloadCallback, object: nil)
    }
}

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
            searchLanguage = language
            viewModel?.resetPage()
            fetchRepositories(language: language)
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repositoryDetailsViewController = RepositoryDetailsViewController()
        
        let repositoryDetailsViewModel = RepositoryDetailsViewModel(searchRepoByIdServices: SearchRepoByIdService())
        repositoryDetailsViewModel.apiRepository = viewModel?.repositories[indexPath.row]
        repositoryDetailsViewController.viewmodel = repositoryDetailsViewModel
        
        navigationController?.pushViewController(repositoryDetailsViewController, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.currentCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusableTableViewCell.identifier, for: indexPath) as? ReusableTableViewCell else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: "CELL")
        }
        if isLoadingCell(for: indexPath) {
//            cell.configure(with: .none)
        } else {
            if let repo = viewModel?.repositories[indexPath.row] {
                cell.setupView(with: repo)
            }
        }
        return cell
    }
}

extension HomeViewController: UITableViewDataSourcePrefetching {

  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    if indexPaths.contains(where: isLoadingCell) {
        print("Deu fetch pelo prefetch")
      viewModel?.fetchRepositories(language: searchLanguage)
    }
  }
}

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
