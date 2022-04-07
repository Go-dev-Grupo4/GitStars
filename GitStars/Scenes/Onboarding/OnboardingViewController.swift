//
//  OnboardingViewController.swift
//  GitStars
//
//  Created by Matheus Lenke on 06/04/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    
    // MARK: - UI Components
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("onboardingTitle", comment: "")
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var githubStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var githubImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "github-logo")
        image.tintColor = .label
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var githubLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("githubLabel", comment: "")
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoritesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var favoritesImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "star")
        image.tintColor = .yellow
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var favoritesLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("favoritesLabel", comment: "")
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var orderStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var orderImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "list.bullet.rectangle.fill")
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("orderLabel", comment: "")
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Continuar", for: .normal)
        button.backgroundColor = Colors.primaryBackgroundColor
        button.layer.cornerRadius = 25
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continuePressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    private func configUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        configButton()
        configStackView()
    }
    
    private func configButton() {
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func configStackView() {
        view.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(githubStackView)
        githubStackView.addArrangedSubview(githubImageView)
        githubStackView.addArrangedSubview(githubLabel)
        
        labelsStackView.addArrangedSubview(favoritesStackView)
        favoritesStackView.addArrangedSubview(favoritesImageView)
        favoritesStackView.addArrangedSubview(favoritesLabel)
        
        labelsStackView.addArrangedSubview(orderStackView)
        orderStackView.addArrangedSubview(orderImageView)
        orderStackView.addArrangedSubview(orderLabel)
        
        let imagesSize = CGFloat(60.0)
        
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 15),
            labelsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            labelsStackView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -50),
            labelsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            githubImageView.heightAnchor.constraint(equalToConstant: imagesSize),
            githubImageView.widthAnchor.constraint(equalToConstant: imagesSize),
            
            favoritesImageView.heightAnchor.constraint(equalToConstant: imagesSize),
            favoritesImageView.widthAnchor.constraint(equalToConstant: imagesSize),
            
            orderImageView.heightAnchor.constraint(equalToConstant: imagesSize),
            orderImageView.widthAnchor.constraint(equalToConstant: imagesSize),
        ])
    }
    
    @objc func continuePressed() {
        self.dismiss(animated: true)
    }

}
