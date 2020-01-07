//
//  SmallAppCell.swift
//  AppStore
//
//  Created by Bob De Kort on 07/01/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import UIKit

class SmallAppCell: UICollectionViewCell, AppConfigurable {
    
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let subtitleLabel = UILabel()
    let buyButton = UIButton(type: .custom)
    let iapLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        
        let textStackView = UIStackView(arrangedSubviews: [nameLabel, subtitleLabel])
        textStackView.axis = .vertical
        textStackView.alignment = .leading
        textStackView.distribution = .fill
        
        let buttonStackView = UIStackView(arrangedSubviews: [buyButton, iapLabel])
        buttonStackView.axis = .vertical
        buttonStackView.alignment = .center
        
        let stackView = UIStackView(arrangedSubviews: [imageView, textStackView, buttonStackView])
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            buttonStackView.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        style()
    }
    
    private func style() {
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameLabel.textColor = .label
        nameLabel.numberOfLines = 0
        
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        buyButton.setImage(UIImage(systemName: "icloud.and.arrow.down"),
                           for: .normal)
        iapLabel.font = UIFont.systemFont(ofSize: 8)
        iapLabel.textColor = .tertiaryLabel
        iapLabel.numberOfLines = 0
        iapLabel.text = "In-App Purchases"
    }
    
    func configure(with app: App) {
        nameLabel.text = app.name
        subtitleLabel.text = app.subTitle
        imageView.image = app.image
        iapLabel.isHidden = !app.hasIAP
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
