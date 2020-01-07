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
    let iapLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        buyButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let innerTextStackView = UIStackView(arrangedSubviews: [nameLabel,
                                                                subtitleLabel])
        innerTextStackView.axis = .vertical
        
        let innerButtonStackView = UIStackView(arrangedSubviews: [buyButton,
                                                                  iapLabel])
        innerButtonStackView.axis = .horizontal
        innerButtonStackView.spacing = 8
        innerButtonStackView.alignment = .leading
        innerButtonStackView.distribution = .fillProportionally
        
        let innerStackView = UIStackView(arrangedSubviews: [innerTextStackView,
                                                            innerButtonStackView])
        innerStackView.axis = .vertical
        innerStackView.spacing = 10
        innerStackView.alignment = .leading
        innerStackView.distribution = .fillProportionally
        
        let outerStackView = UIStackView(arrangedSubviews: [imageView, innerStackView])
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.alignment = .center
        outerStackView.spacing = 10
        outerStackView.distribution = .fillProportionally
        contentView.addSubview(outerStackView)
        
        NSLayoutConstraint.activate([
            outerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            outerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            iapLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 75)
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
        
        buyButton.setImage(UIImage(systemName: "icloud.and.arrow.down"),
                           for: .normal)
        iapLabel.font = UIFont.systemFont(ofSize: 10)
        iapLabel.textColor = .tertiaryLabel
        iapLabel.numberOfLines = 0
        iapLabel.text = "In-App\nPurchases"
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
