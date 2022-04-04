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
            self.tableView.reloadData()
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
        
        tableView.register(ReusableTableViewCell.self, forCellReuseIdentifier: ReusableTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        
        contentView.addSubview(tableView)
        tableView.sizeUpToFillSuperview()
    }
    
    func fetchRepositories(language: String) {
        state = .loading
        viewModel?.fetchRepositories(language: language)
//        timeoutTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(fetchRepositoriesTimeout), userInfo: nil, repeats: false)
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
    
    private func setupDelegates() {
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        //searchController.searchBar.searchTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
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
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        //navigationController?.navigationBar.sizeToFit()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(false, animated: true)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.searchTextField.text = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let language = searchBar.searchTextField.text {
            searchLanguage = language
            fetchRepositories(language: language)
        }
    }
}

extension HomeViewController: UISearchControllerDelegate {
    
    func willPresentSearchController(_ searchController: UISearchController) {
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //searchBar.setShowsScope(false, animated: true)
        //searchBar.resignFirstResponder()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repositoryDetailsViewController = RepositoryDetailsViewController()
        
        let repositoryDetailsViewModel = RepositoryDetailsViewModel(searchRepoByIdServices: SearchRepoByIdService())
        repositoryDetailsViewModel.apiRepository = viewModel?.repositories?[indexPath.row]
        repositoryDetailsViewController.viewmodel = repositoryDetailsViewModel
        
        navigationController?.pushViewController(repositoryDetailsViewController, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
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

extension HomeViewController: RepoManagerDelegate {
    func fetchRepoWithSuccess() {
        self.state = .normal
//        timeoutTimer?.invalidate()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func errorToFetchRepo(_ error: String) {
//        timeoutTimer.
        self.state = .error
    }
}
