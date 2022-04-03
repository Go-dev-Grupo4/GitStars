//
//  ReusableTableViewCell.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 29/03/22.
//

import UIKit

class ReusableTableViewCell: UITableViewCell {
    
    static let identifier = "ReusableTableViewCell"
    
    lazy var mainImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "photo.circle.fill"))
        view.translatesAutoresizingMaskIntoConstraints = false
        // view.autoSetDimensions(to: CGSize(width: 85, height: 85))
        return view
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
        view.spacing = 0
        view.distribution = .fillProportionally
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.adjustsFontSizeToFitWidth = true
        
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Abel", size: 13)
        label.numberOfLines = 3
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configUI() {
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(mainImageView)
        horizontalStackView.addArrangedSubview(contentStackView)
        
        let image = UIImage(named: "seta-direita.png")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        horizontalStackView.addArrangedSubview(imageView)
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        
        
        //accessoryView = imageView
        //self.accessoryType = .disclosureIndicator
        setupConstraints()
    }
    
    public func setupConstraints() {
        
        let padding: CGFloat = 15
        
        horizontalStackView.sizeUpToFillSuperview()
        
        NSLayoutConstraint.activate([
            contentStackView.widthAnchor.constraint(equalToConstant: bounds.width  - 85 - 15),
        ])
        
        NSLayoutConstraint.activate([
            mainImageView.widthAnchor.constraint(equalToConstant: 85),
            mainImageView.heightAnchor.constraint(equalToConstant: 85),
        ])
        
        NSLayoutConstraint.activate([
            mainImageView.widthAnchor.constraint(equalToConstant: 85),
            mainImageView.heightAnchor.constraint(equalToConstant: 85),
        ])
        
        backgroundColor = .red
//        NSLayoutConstraint.activate([
//            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            mainImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            mainImageView.heightAnchor.constraint(equalToConstant: 85),
//            mainImageView.widthAnchor.constraint(equalToConstant: 85),
//
//            contentStackView.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: padding),
//            contentStackView.topAnchor.constraint(equalTo: topAnchor),
//            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            //contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
//
//        ])
        
        
        
//        NSLayoutConstraint.activate([
//            imageView.widthAnchor.constraint(equalToConstant: 12),
//            imageView.heightAnchor.constraint(equalToConstant: 21),
//            contentStackView.trailingAnchor.constraint(equalTo: imageView.leadingAnchor),
//            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
//        ])
    }
    
    func setupView(with model: Any){
        
        configUI()
        
        if let repo = model as? Repo {
            mainImageView.image = UIImage(systemName: "swift")//repo.author.avatarUrl
            titleLabel.text = repo.name
            descriptionLabel.text = repo.repoDescription
        }
        
        if let dev = model as? Desenvolvedor {
            mainImageView.image = UIImage(systemName: "swift")//repo.author.avatarUrl
            titleLabel.text = dev.nome
            descriptionLabel.text = dev.descricao
        }
    }
}
