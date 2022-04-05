//
//  TeamDetailsViewController.swift
//  GitStars
//
//  Created by Matheus Lenke on 03/04/22.
//

import UIKit
import MessageUI

class TeamDetailsViewController: UIViewController {
    
    // MARK: - Variables
    
    var dev: Developer?
    
    var webView: WebViewController?
    
    lazy var devImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo.artframe")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var devDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("defaultDeveloperAboutText", comment: "")
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var telefoneIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "phone")
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var telefoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.label, for: .normal)
        let attributedString = generateLabelText(prefix: NSLocalizedString("phonePrefix", comment: ""), text: "(00)0000-0000")
        button.contentHorizontalAlignment = .left
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(pressedPhone), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var emailIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "envelope")
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
  
    lazy var emailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.label, for: .normal)
        button.setAttributedTitle(generateLabelText(prefix: NSLocalizedString("emailPrefix", comment: ""), text: NSLocalizedString("defaultEmailText", comment: "")), for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(pressedEmail), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var linkedinIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "network")
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var linkedinLabel: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor.label, for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(pressedLinkedin), for: .touchUpInside)
        button.setAttributedTitle(generateLabelText(prefix: NSLocalizedString("linkedinPrefix", comment: ""), text: NSLocalizedString("defaultLinkedinText", comment: "")), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var githubIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "network")
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var githubLabel: UILabel = {
        let label = UILabel()
        label.attributedText = generateLabelText(prefix: NSLocalizedString("githubPrefix", comment: ""), text: NSLocalizedString("defaultGithubText", comment: ""))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        
    }
    
    private func configUI() {
        
        title = NSLocalizedString("teamDetailTitle", comment: "")
        view.backgroundColor = .systemBackground
        
        addAndConfigureElements()
        
        if let dev = dev {
            title = dev.name
            
            devDescriptionLabel.text = dev.description
            devImage.image = dev.image

            telefoneButton.setAttributedTitle(generateLabelText(prefix: NSLocalizedString("phonePrefix", comment: ""), text: dev.phone), for: .normal)
            emailButton.setAttributedTitle(generateLabelText(prefix: NSLocalizedString("emailPrefix", comment: ""), text: dev.email), for: .normal)
            linkedinLabel.setAttributedTitle(generateLabelText(prefix: NSLocalizedString("linkedinPrefix", comment: ""), text: dev.linkedin), for: .normal)
            githubLabel.attributedText = generateLabelText(prefix: NSLocalizedString("githubPrefix", comment: ""), text: dev.github)
        }
    }
    
    private func addAndConfigureElements() {
        
        // ADD ELEMENTS INTO VIEW
        view.addSubview(devImage)
        view.addSubview(devDescriptionLabel)
        view.addSubview(telefoneIcon)
        view.addSubview(telefoneButton)
        view.addSubview(emailIcon)
        view.addSubview(emailButton)
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
            telefoneButton.centerYAnchor.constraint(equalTo: telefoneIcon.centerYAnchor),
            telefoneButton.leadingAnchor.constraint(equalTo: telefoneIcon.trailingAnchor, constant: 16),
            telefoneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            emailIcon.topAnchor.constraint(equalTo: telefoneIcon.bottomAnchor, constant: 16),
            emailIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailIcon.heightAnchor.constraint(equalToConstant: 36),
            emailIcon.widthAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            emailButton.centerYAnchor.constraint(equalTo: emailIcon.centerYAnchor),
            emailButton.leadingAnchor.constraint(equalTo: emailIcon.trailingAnchor, constant: 16),
            emailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
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

// MARK: - Buttons callbacks

extension TeamDetailsViewController {
    
    @objc private func pressedPhone() {
        if let phoneNumber = dev?.phone {
            let scheme = "tel://\(phoneNumber.replacingOccurrences(of: " ", with: ""))"
            
            if let url = URL(string: scheme) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                } else {
                    // Mostra Alert de erro
                }
            }
        }
    }
    
    @objc private func pressedEmail() {
        if let recipient = dev?.email {
            if MFMailComposeViewController.canSendMail() {
                
                let mail = MFMailComposeViewController()
                
                mail.mailComposeDelegate = self
                mail.setToRecipients([recipient])
                
                present(mail, animated: true)
                
            }
        }
    }
    
    @objc private func pressedLinkedin() {
        if let linkedin = dev?.linkedin,
           let url = URL(string: linkedin){
            let request = URLRequest(url: url)
            webView = WebViewController()
            webView?.destinationUrl = linkedin
            self.navigationController?.pushViewController(webView!, animated: true)
        }
    }
}

extension TeamDetailsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
            
        case .cancelled:
            print("cancelled")  
        case .saved:
            print("saved")
        case .sent:
            print("sent")
        case .failed:
            print("failed")
        @unknown default:
            print("default")
        }
        
    }
}
