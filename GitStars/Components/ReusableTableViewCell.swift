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
        
        view.font = UIFont(name: "Abel", size: 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel(frame: .zero)
        
        view.font = UIFont(name: "Abel", size: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
