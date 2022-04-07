//
//  TriStateViewController.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 02/04/22.
//

import UIKit
import SwiftUI

class TriStateViewController: UIViewController {
    
    // MARK: - UI Componenets
    lazy var errorView: ErrorView = {
        let view = ErrorView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        return activity
    }()
    
    // MARK: - Life Cycle
    internal func stopLoading() {
        loadingView.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    // MARK: - Private methods
    private func configUI() {
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupLoadingView() {
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        loadingView.startAnimating()
    }
    
    private func setupErrorView() {
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            errorView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            errorView.heightAnchor.constraint(equalToConstant: 255),
            errorView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
}

extension TriStateViewController: TriStateViewProtocol {
    
    func setupLoadingState() {
        contentView.isHidden = true
        errorView.removeFromSuperview()
        setupLoadingView()
    }
    
    func setupErrorState() {
        loadingView.removeFromSuperview()
        contentView.isHidden = true
        setupErrorView()
    }
    
    func setupNormalState() {
        loadingView.removeFromSuperview()
        errorView.removeFromSuperview()
        contentView.isHidden = false
    }

}
