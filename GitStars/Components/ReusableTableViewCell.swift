//
//  ReusableTableViewCell.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 29/03/22.
//

import UIKit
import Kingfisher

class ReusableTableViewCell: UITableViewCell {
    
    static let identifier = "ReusableTableViewCell"
    
    let mainImageDiameter: CGFloat = 85
    
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo.circle.fill"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = mainImageDiameter / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var contentStackView: UIStackView = {
        let view = UIStackView(frame: .zero)

        view.axis = .vertical
        view.spacing = 0
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    lazy var horizontalStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        
        view.axis = .horizontal
        view.spacing = 12
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 3
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var chevronImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "seta-direita.png")
        image.contentMode = .center
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configUI() {
        addSubview(mainImageView)
        addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(contentStackView)
        horizontalStackView.addArrangedSubview(chevronImageView)
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        
        setupConstraints()
    }
    
    public func setupConstraints() {
        
        NSLayoutConstraint.activate([
            mainImageView.widthAnchor.constraint(equalToConstant: mainImageDiameter),
            mainImageView.heightAnchor.constraint(equalToConstant: mainImageDiameter),
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            chevronImageView.widthAnchor.constraint(equalToConstant: 24),
        ])
        
        NSLayoutConstraint.activate([
            mainImageView.widthAnchor.constraint(equalToConstant: 85),
            mainImageView.heightAnchor.constraint(equalToConstant: 85),
        ])
        
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 15),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
        ])
        
//        mainImageView.layer.cornerRadius = mainImageView.frame.size.height / 2
//        mainImageView.clipsToBounds = true
    }
    
    func setupView(with model: Any){
        
        configUI()
        
        if let repo = model as? Repo {
            if let url = URL(string: repo.author.avatarUrl) {
                mainImageView.kf.setImage(with: url)
            }
            titleLabel.text = repo.name
            descriptionLabel.text = repo.repoDescription
        }
        
        if let repo = model as? Repository {
            if let url = URL(string: repo.avatarURL) {
                mainImageView.kf.setImage(with: url)
            }
            titleLabel.text = repo.repoName
            descriptionLabel.text = repo.repoDescription
        }
        
        if let dev = model as? Desenvolvedor {
            mainImageView.image = dev.image
            titleLabel.text = dev.nome
            descriptionLabel.text = dev.descricao
        }
    }
}
