//
//  ErrorView.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 02/04/22.
//

import UIKit

class ErrorView: UIView {

    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var errorImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "icloud.slash")
        imageView.tintColor = .label
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var errorTitle: UILabel = {
        let label = UILabel()
        
        label.text = "Oops... 👀"
        label.textColor = .label
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var errorDescription: UILabel = {
        let label = UILabel()
        
        label.text = """
        Sorry, the service cannot be run.
            Try again later
        """
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var callbackButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Reload", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.tintColor = .label
        button.setImage(UIImage(systemName: "arrow.counterclockwise"), for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBackground
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 2
        button.setTitleShadowColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sendNoticicationCallback), for: .touchUpInside)
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        configView()
        NotificationCenter.default.post(name: .reloadCallback, object: callbackButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        
        layer.cornerRadius = 34
        
        addSubview(errorImageView)
        addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(errorTitle)
        contentStackView.addArrangedSubview(errorDescription)
        
        NSLayoutConstraint.activate([
            errorImageView.heightAnchor.constraint(equalToConstant: 65),
            errorImageView.widthAnchor.constraint(equalToConstant: 65),
            errorImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            errorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 15),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        addSubview(callbackButton)

        NSLayoutConstraint.activate([
            callbackButton.heightAnchor.constraint(equalToConstant: 40),
            callbackButton.widthAnchor.constraint(equalToConstant: 100),
            callbackButton.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 15),
            callbackButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 255)
    }
    
    @objc private func sendNoticicationCallback() {
        NotificationCenter.default.post(name: .reloadCallback, object: nil)
    }
}
