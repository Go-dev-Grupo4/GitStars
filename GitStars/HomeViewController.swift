//
//  ViewController.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 28/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var safeArea: UILayoutGuide!
    
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
        searchBar.setNeedsFocusUpdate()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}

extension HomeViewController: UISearchTextFieldDelegate {

    
}
