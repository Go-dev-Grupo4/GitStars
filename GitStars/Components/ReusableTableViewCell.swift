//
//  ReusableTableViewCell.swift
//  GitStars
//
//  Created by Idwall Go Dev 003 on 29/03/22.
//

import UIKit

class ReusableTableViewCell: UITableViewCell {
    
    static let identifier = "ReusableTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(mainImageView)
        addSubview(descriptionStackView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    
    lazy var mainImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "photo.circle.fill"))
        view.translatesAutoresizingMaskIntoConstraints = false
        // view.autoSetDimensions(to: CGSize(width: 85, height: 85))
        return view
    }()
    
    lazy var descriptionStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        
        view.axis = .vertical
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
        label.numberOfLines = 2
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
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        addSubview()
        setupConstraints()    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubview() {
        self.addSubview(mainImageView)
        self.addSubview(descriptionLabel)
    }
    
    public func setupConstraints() {
        let padding: CGFloat = 15
        NSLayoutConstraint.activate([
            mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 85),
            mainImageView.widthAnchor.constraint(equalToConstant: 85),
            
            titleLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor,constant: padding),
            titleLabel.topAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 5),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 9),
            descriptionLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            descriptionLabel.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: -9),
            
        ])
        
    }
    
    func setupViews(){
        mainImageView.center = self.center
        titleLabel.text = "Title"
        descriptionLabel.text = "Description Description Description Description Description Description Description Description Description Description Description"
        
    }
}

