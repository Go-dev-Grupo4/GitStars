//
//  RepositoryDetailsViewController.swift
//  GitStars
//
//  Created by Matheus Lenke on 03/04/22.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {
    
    var repository: Any?
    
    var repoCoreDataService: SearchRepoCoreDataService = SearchRepoCoreDataService()
    
    var searchRepoByIdService = SearchRepoByIdService()

    lazy var repoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo.artframe")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
        
    lazy var repoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "A curated list of awesome iOS ecosystem, including Objective-C and Swift Projects"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    lazy var autorIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.crop.square")
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var autorLabel: UILabel = {
        let label = UILabel()
        label.attributedText = generateLabelText(prefix: "Autor", text: "Nome do autor")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var observadoresIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "eye")
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var observadoresLabel: UILabel = {
        let label = UILabel()
        label.attributedText = generateLabelText(prefix: "Contagem de observadores", text: "00000")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dataCriacaoIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "clock.fill")
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var dataCriacaoLabel: UILabel = {
        let label = UILabel()
        label.attributedText = generateLabelText(prefix: "Data de criação", text: "00/00/0000")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var licencaIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "network")
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var licencaLabel: UILabel = {
        let label = UILabel()
        label.attributedText = generateLabelText(prefix: "Licença", text: "MIT License")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var linkRepoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.label, for: .normal)
        button.setTitle("Link do Repositório", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
//        button.addTarget(self, action: #selector(fazerNavegacao), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Favoritar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupData()
    }
    
    private func setupData() {
        if let repositoryFromHome = repository as? Repo {
            searchRepoByIdService.execute(id: repositoryFromHome.id, datasource: .coreData) { result in
                switch result {
                case .success(let repo):
                    guard let repo = repo as? Repository else { return }
                    if repo.isFavorite {
                        DispatchQueue.main.async {
                            self.favoriteButton.setTitle("Desfavoritar", for: .normal)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
            title = repositoryFromHome.name
            
            if let url = URL(string: repositoryFromHome.author.avatarUrl) {
                repoImage.kf.setImage(with: url)
            }
            repoDescriptionLabel.text = repositoryFromHome.repoDescription
            autorLabel.attributedText = generateLabelText(prefix: "Autor", text: repositoryFromHome.author.login)
            observadoresLabel.attributedText = generateLabelText(prefix: "Contagem de observadores", text: "\(repositoryFromHome.watchers)")
            dataCriacaoLabel.attributedText = generateLabelText(prefix: "Data de criação", text: repositoryFromHome.createdAt)
            licencaLabel.attributedText = generateLabelText(prefix: "Licença", text: repositoryFromHome.license?.name ?? "Sem licença")
            return
        }
        
        if let repositoryFromFavorites = repository as? Repository {
            searchRepoByIdService.execute(id: repositoryFromFavorites.id, datasource: .api) { result in
                switch result {
                case .success(let repo):
                    guard let repo = repo as? Repo else { return }
                    
                    DispatchQueue.main.async {
                        self.title = repo.name
                        if let url = URL(string: repo.author.avatarUrl) {
                            self.repoImage.kf.setImage(with: url)
                        }
                        self.repoDescriptionLabel.text = repo.repoDescription
                        self.autorLabel.attributedText = self.generateLabelText(prefix: "Autor", text: repo.author.login)
                        self.observadoresLabel.attributedText = self.generateLabelText(prefix: "Contagem de observadores", text: "\(repo.watchers)")
                        self.dataCriacaoLabel.attributedText = self.generateLabelText(prefix: "Data de criação", text: repo.createdAt)
                        self.licencaLabel.attributedText = self.generateLabelText(prefix: "Licença", text: repo.license?.name ?? "Sem licença")
                        if repositoryFromFavorites.isFavorite {
                            self.favoriteButton.setTitle("Desfavoritar", for: .normal)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
           
        }
    }

    private func configUI() {
        
        title = "Nome do repositório"
        view.backgroundColor = .systemBackground
        
        addAndConfigureElements()
    }
    
    private func addAndConfigureElements() {

        // ADD ELEMENTS INTO VIEW
        view.addSubview(repoImage)
        view.addSubview(repoDescriptionLabel)
        view.addSubview(autorIcon)
        view.addSubview(autorLabel)
        view.addSubview(observadoresIcon)
        view.addSubview(observadoresLabel)
        view.addSubview(dataCriacaoIcon)
        view.addSubview(dataCriacaoLabel)
        view.addSubview(licencaIcon)
        view.addSubview(licencaLabel)
        view.addSubview(linkRepoButton)
        view.addSubview(favoriteButton)

        // CONFIGURE ELEMENTS CONSTRAINTS
        NSLayoutConstraint.activate([
            repoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            repoImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            repoImage.heightAnchor.constraint(equalToConstant: 150),
            repoImage.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            repoDescriptionLabel.topAnchor.constraint(equalTo: repoImage.bottomAnchor, constant: 23),
            repoDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            repoDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            autorIcon.topAnchor.constraint(equalTo: repoDescriptionLabel.bottomAnchor, constant: 16),
            autorIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            autorIcon.heightAnchor.constraint(equalToConstant: 36),
            autorIcon.widthAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            autorLabel.centerYAnchor.constraint(equalTo: autorIcon.centerYAnchor),
            autorLabel.leadingAnchor.constraint(equalTo: autorIcon.trailingAnchor, constant: 16),
            autorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            observadoresIcon.topAnchor.constraint(equalTo: autorIcon.bottomAnchor, constant: 16),
            observadoresIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            observadoresIcon.heightAnchor.constraint(equalToConstant: 36),
            observadoresIcon.widthAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            observadoresLabel.centerYAnchor.constraint(equalTo: observadoresIcon.centerYAnchor),
            observadoresLabel.leadingAnchor.constraint(equalTo: observadoresIcon.trailingAnchor, constant: 16),
            observadoresLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            dataCriacaoIcon.topAnchor.constraint(equalTo: observadoresIcon.bottomAnchor, constant: 16),
            dataCriacaoIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dataCriacaoIcon.heightAnchor.constraint(equalToConstant: 36),
            dataCriacaoIcon.widthAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            dataCriacaoLabel.centerYAnchor.constraint(equalTo: dataCriacaoIcon.centerYAnchor),
            dataCriacaoLabel.leadingAnchor.constraint(equalTo: dataCriacaoIcon.trailingAnchor, constant: 16),
            dataCriacaoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            licencaIcon.topAnchor.constraint(equalTo: dataCriacaoIcon.bottomAnchor, constant: 16),
            licencaIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            licencaIcon.heightAnchor.constraint(equalToConstant: 36),
            licencaIcon.widthAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            licencaLabel.centerYAnchor.constraint(equalTo: licencaIcon.centerYAnchor),
            licencaLabel.leadingAnchor.constraint(equalTo: licencaIcon.trailingAnchor, constant: 16),
            licencaLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            linkRepoButton.topAnchor.constraint(equalTo: licencaLabel.bottomAnchor, constant: 50),
            linkRepoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: linkRepoButton.bottomAnchor, constant: 15),
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    // CREATES A CUSTOM UILabel WITH A BOLD FONT PREFIX AND A REGULAR FONT CONTENT
    private func generateLabelText(prefix: String, text: String) -> NSMutableAttributedString {
        let boldAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]
        let regularAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let boldText = NSAttributedString(string: prefix, attributes: boldAttribute)
        let boldSeparator = NSAttributedString(string: ": ", attributes: boldAttribute)
        let regularText = NSAttributedString(string: text, attributes: regularAttribute)
        let newString = NSMutableAttributedString()
        newString.append(boldText)
        newString.append(boldSeparator)
        newString.append(regularText)
        return newString
    }
    
    @objc private func favoriteButtonPressed() {
        repoCoreDataService.execute { result in
            switch result {
            case .success(let repositories):
                if repositories.count > 0 {
                    if let repo = self.repository as? Repo {
                        ManagedObjectContext.shared.delete(id: repo.id) { error in
                            print(error)
                        }
                    } else if let repo = self.repository as? Repository {
                        ManagedObjectContext.shared.delete(id: repo.id) { error in
                            print(error)
                        }
                    }
                } else {
                    if let repo = self.repository as? Repo {
                        let newRepo = Repository(id: repo.id, repoName: repo.name, repoDescription: repo.repoDescription ?? "Sem descrição", avatarURL: repo.author.avatarUrl, isFavorite: true)
                        ManagedObjectContext.shared.save(repository: newRepo) { error in
                            print(error)
                        }
                    } else if let repo = self.repository as? Repository {
                        ManagedObjectContext.shared.save(repository: repo) { error in
                            print(error)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func addFavoriteRepo() {
        
    }
    
    private func removeFavoriteRepo() {
        
    }

}
