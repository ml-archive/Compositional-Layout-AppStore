//
//  SmallAppCell.swift
//  AppStore
//
//  Created by Bob De Kort on 07/01/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import UIKit

class SmallAppCell: UICollectionViewCell {
    static let reuseIdentifier: String = "SmallAppCell"
    
    let nameLabel = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 20
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        style()
    }
    
    private func style() {
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        nameLabel.textColor = .label
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
    }
    
    func configure(with app: App) {
        nameLabel.text = app.name
        imageView.image = app.image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
