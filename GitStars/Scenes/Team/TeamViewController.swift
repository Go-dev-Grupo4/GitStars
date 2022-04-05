//
//  TeamViewController.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 28/03/22.
//

import UIKit

class TeamViewController: UIViewController {

    // MARK: - Variables
    
    var safeArea: UILayoutGuide!
    
    var developers: [Developer] = []
    
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
        safeArea = view.layoutMarginsGuide
        
        configUI()
        getDataMock()
        setupDelegates()
    }
    
    // MARK: - Private functions
    
    private func configUI() {
        title = NSLocalizedString("teamTitle", comment: "")
        view.backgroundColor = .systemBackground
        
        tableView.register(ReusableTableViewCell.self, forCellReuseIdentifier: ReusableTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    private func getDataMock() {
        developers = DataSource.developers
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension TeamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamDetailsViewController = TeamDetailsViewController()
        
        let dev = developers[indexPath.row]
        teamDetailsViewController.dev = dev
        navigationController?.pushViewController(teamDetailsViewController, animated: true)
    }
}

extension TeamViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusableTableViewCell.identifier, for: indexPath) as? ReusableTableViewCell else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: "CELL")
        }
        let dev = developers[indexPath.row]
        cell.setupView(with: dev)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return developers.count
    }
}
