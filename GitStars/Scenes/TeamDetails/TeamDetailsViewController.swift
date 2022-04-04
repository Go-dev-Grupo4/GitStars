//
//  TeamDetailsViewController.swift
//  GitStars
//
//  Created by Matheus Lenke on 03/04/22.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    
    // MARK: - Variables
    
    var dev: Desenvolvedor?

    lazy var devImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo.artframe")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
        
    lazy var devDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Fale um pouco sobre você."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    lazy var telefoneIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "phone")
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var telefoneLabel: UILabel = {
        let label = UILabel()
        label.attributedText = generateLabelText(prefix: "Telefone", text: "(00)0000-0000")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "envelope")
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.attributedText = generateLabelText(prefix: "Email", text: "fulano@fulano.com.br")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var linkedinIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "network")
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var linkedinLabel: UILabel = {
        let label = UILabel()
        label.attributedText = generateLabelText(prefix: "Linkedin", text: "url")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var githubIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "network")
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var githubLabel: UILabel = {
        let label = UILabel()
        label.attributedText = generateLabelText(prefix: "Github", text: "url (Opcional)")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        
    }

    private func configUI() {
        
        title = "Nome"
        view.backgroundColor = .white
        
        addAndConfigureElements()
        
        if let dev = dev {
            title = dev.nome
            
            devDescriptionLabel.text = dev.descricao
            devImage.image = dev.image
            telefoneLabel.attributedText = generateLabelText(prefix: "Telefone", text: dev.telefone)
            emailLabel.attributedText = generateLabelText(prefix: "Email", text: dev.email)
            linkedinLabel.attributedText = generateLabelText(prefix: "Linkedin", text: dev.linkedin)
            githubLabel.attributedText = generateLabelText(prefix: "Github", text: dev.github)
        }
    }
    
    private func addAndConfigureElements() {

        // ADD ELEMENTS INTO VIEW
        view.addSubview(devImage)
        view.addSubview(devDescriptionLabel)
        view.addSubview(telefoneIcon)
        view.addSubview(telefoneLabel)
        view.addSubview(emailIcon)
        view.addSubview(emailLabel)
        view.addSubview(linkedinIcon)
        view.addSubview(linkedinLabel)
        view.addSubview(githubIcon)
        view.addSubview(githubLabel)

        // CONFIGURE ELEMENTS CONSTRAINTS
        NSLayoutConstraint.activate([
            devImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            devImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            devImage.heightAnchor.constraint(equalToConstant: 150),
            devImage.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            devDescriptionLabel.topAnchor.constraint(equalTo: devImage.bottomAnchor, constant: 23),
            devDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            devDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            telefoneIcon.topAnchor.constraint(equalTo: devDescriptionLabel.bottomAnchor, constant: 36),
            telefoneIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            telefoneIcon.heightAnchor.constraint(equalToConstant: 36),
            telefoneIcon.widthAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            telefoneLabel.centerYAnchor.constraint(equalTo: telefoneIcon.centerYAnchor),
            telefoneLabel.leadingAnchor.constraint(equalTo: telefoneIcon.trailingAnchor, constant: 16),
            telefoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            emailIcon.topAnchor.constraint(equalTo: telefoneIcon.bottomAnchor, constant: 16),
            emailIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailIcon.heightAnchor.constraint(equalToConstant: 36),
            emailIcon.widthAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.centerYAnchor.constraint(equalTo: emailIcon.centerYAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: emailIcon.trailingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            linkedinIcon.topAnchor.constraint(equalTo: emailIcon.bottomAnchor, constant: 16),
            linkedinIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            linkedinIcon.heightAnchor.constraint(equalToConstant: 36),
            linkedinIcon.widthAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            linkedinLabel.centerYAnchor.constraint(equalTo: linkedinIcon.centerYAnchor),
            linkedinLabel.leadingAnchor.constraint(equalTo: linkedinIcon.trailingAnchor, constant: 16),
            linkedinLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            githubIcon.topAnchor.constraint(equalTo: linkedinIcon.bottomAnchor, constant: 16),
            githubIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            githubIcon.heightAnchor.constraint(equalToConstant: 36),
            githubIcon.widthAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            githubLabel.centerYAnchor.constraint(equalTo: githubIcon.centerYAnchor),
            githubLabel.leadingAnchor.constraint(equalTo: githubIcon.trailingAnchor, constant: 16),
            githubLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
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

}
