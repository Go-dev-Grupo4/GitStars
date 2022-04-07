//
//  TeamViewController.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 28/03/22.
//

import UIKit

class TeamViewController: TriStateViewController {

    // MARK: - Variables
    var viewModel: TeamViewModel?
    
    var safeArea: UILayoutGuide!
    
    private var state: ViewState = .loading {
        didSet {
            DispatchQueue.main.async {
                self.setupView()
            }
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
        safeArea = view.layoutMarginsGuide
        
        configUI()
        setupDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        state = .loading
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchTeam()
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
    
    private func fetchTeam() {
        viewModel?.fetchTeam()
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        viewModel?.delegate = self
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
}

// MARK: - UITableViewDelegate
extension TeamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dev = viewModel?.team?.members[indexPath.row] else { return }
        
        viewModel?.showDetail(dev: dev)
    }
}

// MARK: - UITableViewDataSource
extension TeamViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReusableTableViewCell.identifier, for: indexPath) as? ReusableTableViewCell,
              let dev = viewModel?.team?.members[indexPath.row] else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: "CELL")
        }
    
        cell.setupView(with: dev)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.team?.members.count ?? 0
    }
}

// MARK: - TeamManagerDelegate
extension TeamViewController: TeamManagerDelegate {
    func fetchTeamWithSuccess() {
        self.state = .normal
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func errorToFetchTeam(_ error: String) {
        self.state = .error
    }
}
