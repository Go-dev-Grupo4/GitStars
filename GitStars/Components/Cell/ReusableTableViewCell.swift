//
//  ReusableTableViewCell.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 29/03/22.
//

import UIKit
import Kingfisher

class ReusableTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    static let identifier = "ReusableTableViewCell"
    
    let mainImageDiameter: CGFloat = 85
    
    // MARK: - UI Components
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
        label.font = .init(name: "SFProText-Regular", size: 17)
        label.textColor = Colors.primaryLabelColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .init(name: "SFProText-Regular", size: 14)
        label.textColor = Colors.secondaryLabelColor
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
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Event methods
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Public methods
    func configUI() {
        addSubview(mainImageView)
        addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(contentStackView)
        horizontalStackView.addArrangedSubview(chevronImageView)
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
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
            horizontalStackView.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: Metrics.Margin.mainImageTrailing),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Metrics.Margin.trailingStackView),
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.Margin.topStackView),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Metrics.Margin.bottonStackView),
        ])
        
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
        
        if let repo = model as? FavoritesModel {
            if let url = URL(string: repo.avatarURL) {
                mainImageView.kf.setImage(with: url)
            }
            titleLabel.text = repo.repoName
            descriptionLabel.text = repo.repoDescription
        }
        
        if let dev = model as? Developer {
            mainImageView.image = dev.image
            titleLabel.text = dev.name
            descriptionLabel.text = dev.description
        }
    }
}
