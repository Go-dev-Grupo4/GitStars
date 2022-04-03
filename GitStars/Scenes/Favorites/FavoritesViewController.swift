//
//  FavoritesViewController.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 28/03/22.
//

import UIKit

class FavoritesViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Favoritos"
        view.backgroundColor = .yellow
    }
    
}
