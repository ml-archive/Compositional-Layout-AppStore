//
//  FeaturedCell.swift
//  AppStore
//
//  Created by Bob De Kort on 06/01/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import UIKit

class FeaturedCell: UICollectionViewCell, AppConfigurable {
    
    // UI components
    let typeLabel = UILabel()
    let nameLabel = UILabel()
    let subtitleLabel = UILabel()
    let imageView = UIImageView()
    
    // Initialiser
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    /// Sets up the UI components for this cell and adds them to the contentview
    private func setup() {
        // Separator is a line at the top of the cell to visually separate it from the Navigation bar
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .separator
        
        // Constructing our main stack view with all the UI components we defined above
        let stackView = UIStackView(arrangedSubviews: [separator, typeLabel, nameLabel, subtitleLabel, imageView])
        stackView.axis = .vertical
        
        // We will define our own constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the stackview to the content view
        contentView.addSubview(stackView)
        
        // Constraint the stackview to all 4 edges of the content view
        // Constraint the separator height to 0.5
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // Adds custom spacing to the stackview
        stackView.setCustomSpacing(10, after: separator)
        stackView.setCustomSpacing(10, after: subtitleLabel)
        
        style()
    }
    
    /// Styles all the UI components in the cell
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
    
    /// Configures the cell with a given app
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
