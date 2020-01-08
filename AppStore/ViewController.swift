//
//  ViewController.swift
//  AppStore
//
//  Created by Bob De Kort on 06/01/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties -
    private var presenter = AppsPresenter()         // Handles all the data
    private var collectionView: UICollectionView!

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Apps"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupCollectionView()
    }

    // MARK: - Setup methods -
    /// Constructs the UICollectionView and adds it to the view.
    /// Registers all the Cells and Views that the UICollectionView will need
    private func setupCollectionView() {
        // Initialises the collection view with a CollectionViewLayout which we will define
        collectionView = UICollectionView.init(frame: .zero,
                                               collectionViewLayout: makeLayout())
        // Assigning data source and background color
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        // Adding the collection view to the view
        view.addSubview(collectionView)
        
        // This line tells the system we will define our own constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraining the collection view to the 4 edges of the view
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Registering all Cells and Classes we will need
        
    }

    
    // MARK: - Collection View Helper Methods -
    // In this section you can find all the layout related code
    
    /// Creates the appropriate UICollectionViewLayout for each section type
    private func makeLayout() -> UICollectionViewLayout {
        return UICollectionViewLayout()
    }
}

// MARK: - UICollectionViewDataSource -

extension ViewController: UICollectionViewDataSource {
    /// Tells the UICollectionView how many sections are needed
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections
    }
    
    /// Tells the UICollectionView how many items the requested sections needs
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems(for: section)
    }
    
    /// Constructs and configures the item needed for the requested IndexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Checks what section type we should use for this indexPath so we use the right cells for that section
        switch presenter.sectionType(for: indexPath.section) {
        case .singleList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCell.identifier, for: indexPath) as? FeaturedCell else {
                fatalError("Could not dequeue FeatureCell")
            }
            
            presenter.configure(item: cell, for: indexPath)
            
            return cell
        
        case .doubleList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediumAppCell.identifier, for: indexPath) as? MediumAppCell else {
                fatalError("Could not dequeue MediumAppCell")
            }
            
            presenter.configure(item: cell, for: indexPath)
            
            return cell
        case .tripleList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallAppCell.identifier, for: indexPath) as? SmallAppCell else {
                fatalError("Could not dequeue SmallAppCell")
            }
            
            presenter.configure(item: cell, for: indexPath)
            
            return cell
        case .categoryList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallCategoryCell.identifier, for: indexPath) as? SmallCategoryCell else {
                fatalError("Could not dequeue SmallCategoryCell")
            }
            
            presenter.configure(item: cell, for: indexPath)
            
            return cell
        }
    }
    
    /// Constructs and configures the Supplementary Views for the UICollectionView
    /// In this project only used for the Section Headers
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.identifier, for: indexPath) as? SectionHeader else {
            fatalError("Could not dequeue SectionHeader")
        }
        
        // If the section has a title show it in the Section header, otherwise hide the titleLabel
        if let title = presenter.title(for: indexPath.section) {
            headerView.titleLabel.text = title
            headerView.titleLabel.isHidden = false
        } else {
            headerView.titleLabel.isHidden = true
        }
        
        // If the section has a subtitle show it in the Section header, otherwise hide the subtitleLabel
        if let subtitle = presenter.subtitle(for: indexPath.section) {
            headerView.subtitleLabel.text = subtitle
            headerView.subtitleLabel.isHidden = false
        } else {
            headerView.subtitleLabel.isHidden = true
        }
        
        return headerView
    }
}
