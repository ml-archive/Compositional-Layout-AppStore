//
//  FeaturedCell.swift
//  AppStore
//
//  Created by Bob De Kort on 06/01/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import UIKit

class FeaturedCell: UICollectionViewCell {
    static let reuseIdentifier: String = "FeaturedCell"
    
    let typeLabel = UILabel()
    let nameLabel = UILabel()
    let subtitleLabel = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    private func setup() {
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .quaternaryLabel
        
        let stackView = UIStackView(arrangedSubviews: [separator, typeLabel, nameLabel, subtitleLabel, imageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stackView.setCustomSpacing(10, after: separator)
        stackView.setCustomSpacing(10, after: subtitleLabel)
        
        style()
    }
    
    private func style() {
        typeLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        typeLabel.textColor = .systemBlue
        
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        nameLabel.textColor = .label
        
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.textColor = .secondaryLabel
        
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
    
    func configure(with app: App) {
        typeLabel.text = app.type.uppercased()
        nameLabel.text = app.name
        subtitleLabel.text = app.subTitle
        imageView.image = app.image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
