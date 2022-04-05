//
//  RepositoryDetailsViewController.swift
//  GitStars
//
//  Created by Matheus Lenke on 03/04/22.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {
    
    // MARK: - Variables
    
    var viewmodel: RepositoryDetailsViewModel?

    // MARK: - UI Elements
    
    lazy var repoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo.artframe")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
        
    lazy var repoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("defaultDescriptionText", comment: "")
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
        label.attributedText = generateLabelText(prefix: NSLocalizedString("authorPrefix", comment: ""), text: NSLocalizedString("defaultAuthorText", comment: ""))
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
        label.attributedText = generateLabelText(prefix: NSLocalizedString("watchersPrefix", comment: ""), text: "00000")
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
        label.attributedText = generateLabelText(prefix: NSLocalizedString("creationDatePrefix", comment: ""), text: "00/00/0000")
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
        label.attributedText = generateLabelText(prefix: NSLocalizedString("licensePrefix", comment: ""), text: NSLocalizedString("defaultLicenseText", comment: ""))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var linkRepoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.label, for: .normal)
        button.setTitle(NSLocalizedString("repositoryLinkTitle", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(pressedRepositoryLink), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("makeFavoriteTitle", comment: ""), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        configUI()
        setupData()
    }
    
    // MARK: - Private Functions
    
    private func setupDelegates() {
        viewmodel?.delegate = self
    }

    private func configUI() {
        
        title = NSLocalizedString("repositoryDetailTitle", comment: "")
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
    
    // CREATES A CUSTOM NSMutableAttributedString WITH A BOLD FONT PREFIX AND A REGULAR FONT CONTENT
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
    
    private func setupData() {
        guard let viewmodel = viewmodel else {
            return
        }
        
        // Se o repositório vier da API, precisamos verificar se o mesmo está nos favoritos do CoreData
        if let repositoryFromHome = viewmodel.apiRepository {
            viewmodel.fetchRepositoryCoreData()
            if let url = URL(string: repositoryFromHome.author.avatarUrl) {
                repoImage.kf.setImage(with: url)
            }
            repoDescriptionLabel.text = repositoryFromHome.repoDescription
            autorLabel.attributedText = generateLabelText(prefix: NSLocalizedString("authorPrefix", comment: ""), text: repositoryFromHome.author.login)
            observadoresLabel.attributedText = generateLabelText(prefix: NSLocalizedString("watchersPrefix", comment: ""), text: "\(repositoryFromHome.watchers)")
            dataCriacaoLabel.attributedText = generateLabelText(prefix: NSLocalizedString("creationDatePrefix", comment: ""), text: repositoryFromHome.createdAt)
            licencaLabel.attributedText = generateLabelText(prefix: NSLocalizedString("licensePrefix", comment: ""), text: repositoryFromHome.license?.name ?? NSLocalizedString("defaultNoLicenseText", comment: ""))
            title = repositoryFromHome.name
            return
        }
        
        // Se o repositório vier do CoreData, precisamos pegar seus detalhes na API
        if let repositoryFromCoreData = viewmodel.coreDataRepository {
            viewmodel.fetchRepositoryApi()
            changeFavoriteButtonTitle(isFavorite: repositoryFromCoreData.isFavorite)
        }
    }
    
    @objc private func favoriteButtonPressed() {
        guard let viewmodel = viewmodel else {
            return
        }
        viewmodel.changeRepositoryFavoriteStatus()
    }
    
    private func changeFavoriteButtonTitle(isFavorite: Bool) {
        DispatchQueue.main.async {
            if isFavorite {
                self.favoriteButton.setTitle(NSLocalizedString("undoFavoriteTitle", comment: ""), for: .normal)
            } else {
                self.favoriteButton.setTitle(NSLocalizedString("favoriteTitle", comment: ""), for: .normal)
            }
        }
    }
    
    private func showAlertError(message: String) {
        let alertController = UIAlertController(title: NSLocalizedString("errorAlertTitle", comment: ""), message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
    }
    
//    private func parseDate(date: String) -> String? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        if let date = dateFormatter.date(from: date) {
//            
//        }
//    }
    
    @objc private func pressedRepositoryLink() {
        
        if let github = viewmodel?.apiRepository?.url,
           let url = URL(string: github){
            let webView = WebViewController()
            webView.destinationUrl = github
            self.navigationController?.pushViewController(webView, animated: true)
        }
        
    }
}

// MARK: - RepositoryDetailsManagerDelegate

extension RepositoryDetailsViewController: RepositoryDetailsManagerDelegate {
    func fetchRepoWithSuccessApi() {
        guard let apiRepo = viewmodel?.apiRepository else { return }
        
        DispatchQueue.main.async {
            self.title = apiRepo.name
            if let url = URL(string: apiRepo.author.avatarUrl) {
                self.repoImage.kf.setImage(with: url)
            }
            self.repoDescriptionLabel.text = apiRepo.repoDescription
            self.autorLabel.attributedText = self.generateLabelText(prefix: NSLocalizedString("authorPrefix", comment: ""), text: apiRepo.author.login)
            self.observadoresLabel.attributedText = self.generateLabelText(prefix: NSLocalizedString("watchersPrefix", comment: ""), text: "\(apiRepo.watchers)")
            self.dataCriacaoLabel.attributedText = self.generateLabelText(prefix: NSLocalizedString("creationDatePrefix", comment: ""), text: apiRepo.createdAt)
            self.licencaLabel.attributedText = self.generateLabelText(prefix: NSLocalizedString("licensePrefix", comment: ""), text: apiRepo.license?.name ?? NSLocalizedString("defaultNoLicenseText", comment: ""))
        }
    }
    
    func errorToFetchRepoApi(_ error: String) {
        print(error)
    }
    
    func fetchRepoWithSuccessCoreData() {
        if let coreDataRepo = viewmodel?.coreDataRepository {
            if coreDataRepo.isFavorite {
                changeFavoriteButtonTitle(isFavorite: true)
            }
        }
        title = viewmodel?.coreDataRepository?.repoName
    }
    
    func errorToFetchRepoCoreData(_ error: String) {
        self.showAlertError(message: error)
    }
    
    func favoritedRepoSuccess() {
        changeFavoriteButtonTitle(isFavorite: true)
    }
    
    func favoritedRepoError(_ error: String) {
        self.showAlertError(message: error)
    }
    
    func unfavoritedRepoSuccess() {
        changeFavoriteButtonTitle(isFavorite: false)
    }
    
    func unfavoritedRepoError(_ error: String) {
        self.showAlertError(message: error)
    }
    
}
