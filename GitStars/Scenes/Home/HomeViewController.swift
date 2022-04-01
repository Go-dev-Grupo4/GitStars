//
//  ViewController.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 28/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum HomeViewState {
        case loading
        case normal
        case error
    }
    
    let searchRepoService = SearchRepoService()
    
    // MARK: - Variables
    
    var safeArea: UILayoutGuide!
    
    var viewModel: RepoViewModel?
    
    private var state: HomeViewState = .normal {
        didSet {
            self.setupHomeView()
        }
    }
    
    private func setupHomeView() {
        switch state {
        case .loading:
            print("loading")
            // Carrega o loading
        case .normal:
            print("normal")
            // remover o loading
            // carregar informações na tabela
        case .error:
            print("error")
            // remover o loading
            // Notificar o usuário que algo deu errado
        }
    }
    
    
    // MARK: - UI Components
    
    lazy var searchBar: UISearchBar! = {
        let searchBar = UISearchBar(frame: .zero)
        
        //        searchBar.layer.borderColor = UIColor.label.cgColor
        //        searchBar.layer.borderWidth = 3
        searchBar.searchBarStyle = .minimal
        //        searchBar.searchBarStyle = .prominent
        searchBar.layer.shadowColor = .none
        searchBar.searchTextField.borderStyle = .roundedRect
        searchBar.setShowsCancelButton(false, animated: true)

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        safeArea = view.layoutMarginsGuide
        
        viewModel?.delegate = self
        
        configUI()
        setupDelegates()
    }
    
    // MARK: - Private functions
    
    private func configUI() {
        title = "List"
        view.backgroundColor = .systemBackground
        
        configNavigationBar()
        configSearchBar()
    }
    
    private func configNavigationBar() {
        let barButtonImage = UIImage(systemName: "slider.horizontal.3")
        let barButtonItem = UIBarButtonItem(image: barButtonImage, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .label
        
        let apearence = UINavigationBarAppearance()
        apearence.shadowColor = UIColor.clear
    }
    
    private func configSearchBar() {
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
        ])
    }
    
    private func setupDelegates() {
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
    }
    
    private func fetchRepositories(language: String) {
        guard let viewModel = viewModel else { return state = .error }
        viewModel.fetchRepositories(language: language)
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
        searchBar.setNeedsFocusUpdate()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let language = searchBar.searchTextField.text else { return }
        
        self.fetchRepositories(language: language)
    }
}

// MARK: - UISearchTextFieldDelegate

extension HomeViewController: UISearchTextFieldDelegate {

    
}

// MARK: - RepoViewModelDelegate

extension HomeViewController: RepoViewModelDelegate {
    func fetchRepoWithSuccess() {
        print("Success")
        viewModel?.repositories?.forEach({ repo in
            print(repo.name)
        })
        // ReloadData
        state = .normal
    }
    
    func errorToFetchRepo(_ error: String) {
        print("Error")
        state = .error
    }
    
}
