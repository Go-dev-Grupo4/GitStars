//
//  ViewController.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 28/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var safeArea: UILayoutGuide!
    var toogle = true
    
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
        
        view.addSubview(tableView)
        
        
        //        let constraint = NSLayoutConstraint.init(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 200)
        //        constraint.isActive = true
        
        // Nativo usando o NSLayoutConstraint.activate
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        // Nativo usando o isActive
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        // Extension 1
        tableView
            .topAnchorToTopAnchor(0)
            .end()
        
        // Extension 2
        tableView
            .anchored(.top, to: .top, by: 0)
            .end()
        
        // Extension 3 com superview default e constant default em 0
        tableView
            .attach(.top, to: .top)
            .end()
        
        // Sobrecarga da extension 3 setando uma view e constant default em 0
        tableView
            .attach(.top, to: .top, of: view)
            .end()
        // Sobrecarga da extension 3 setando todos os parameetros
        tableView
            .attach(.top, to: .top, of: view, by: 0)
            .end()
        
        tableView
            .topAnchorToTopAnchor(0)
            .leadingAnchorToLeadingAnchor(0)
            .bottomAnchorToBottomAnchor(0)
            .trailingAnchorToTrailingAnchor(0)
            .end()
        
        
        
        //        NSLayoutConstraint.activate([
        //            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
        //            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
        //            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        //            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        //        ])
        
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: ReusableTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        
        
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
        return 85
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ReusableTableViewCell.identifier, for: indexPath) as? ReusableTableViewCell {
            
            let image = UIImage(named: "seta-direita.png")
            let imageView = UIImageView(image: image)
            cell.accessoryView = imageView
            
            cell.setupConstraints()
            cell.setupViews()
            
            
            return cell
        }
        
        
        return UITableViewCell(style: .subtitle, reuseIdentifier: "CELL")
    }
    
//    extension HomeViewController: UITableViewCell
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return 85
//        }
    
}
