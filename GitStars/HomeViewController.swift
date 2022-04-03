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
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        safeArea = view.layoutMarginsGuide
        
        configUI()
        setupDelegates()
        
    }
    
    private func configUI() {
        title = "List"
        view.backgroundColor = .systemBackground
        
        configNavigationBar()
        configSearchBar()
                        
        state = .loading
        //Teste
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(loadError), userInfo: nil, repeats: false)
        
        contentView.addSubview(tableView)

        tableView.sizeUpToFillSuperview()
    }
    
    //Teste
    @objc func loadError() {
        state = .error
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(loadLoadging), userInfo: nil, repeats: false)

    }
    
    //Teste
    @objc func loadNormal() {
        state = .normal
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(loadLoadging), userInfo: nil, repeats: false)
    }
    
    //Teste
    @objc func loadLoadging() {
        state = .loading
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(loadError), userInfo: nil, repeats: false)

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
    
    var handler: UIActionHandler = { action in
        
    }
    
    private func configSearchBar() {
        
        self.navigationItem.searchController = searchController
        
    }
    
    private func setupDelegates() {
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
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

extension HomeViewController: UITextFieldDelegate {
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //searchController.searchBar.showsScopeBar = false
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CELL")
        
        cell.sizeToFit()
        cell.textLabel?.text = "Teste"
        
        return cell
    }
}
