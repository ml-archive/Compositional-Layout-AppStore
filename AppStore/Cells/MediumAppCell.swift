//
//  MediumAppCell.swift
//  AppStore
//
//  Created by Bob De Kort on 06/01/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import UIKit

class MediumAppCell: UICollectionViewCell {
    static let reuseIdentifier: String = "MediumAppCell"
    
    let nameLabel = UILabel()
    let subtitleLabel = UILabel()
    let imageView = UIImageView()
    let buyButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        buyButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let innerStackView = UIStackView(arrangedSubviews: [nameLabel, subtitleLabel])
        innerStackView.axis = .vertical
        
        let outerStackView = UIStackView(arrangedSubviews: [imageView, innerStackView, buyButton])
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.alignment = .center
        outerStackView.spacing = 10
        contentView.addSubview(outerStackView)
        
        NSLayoutConstraint.activate([
            outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 65)
        ])
        
        style()
    }
    
    private func style() {
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        nameLabel.textColor = .label
        
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitleLabel.textColor = .secondaryLabel
        
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        buyButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
    }
    
    func configure(with app: App) {
        nameLabel.text = app.name
        subtitleLabel.text = app.subTitle
        imageView.image = app.image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
