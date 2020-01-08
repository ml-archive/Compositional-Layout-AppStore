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
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.identifier)
        collectionView.register(FeaturedCell.self,
                                forCellWithReuseIdentifier: FeaturedCell.identifier)
        collectionView.register(MediumAppCell.self,
                                forCellWithReuseIdentifier: MediumAppCell.identifier)
        collectionView.register(SmallAppCell.self,
                                forCellWithReuseIdentifier: SmallAppCell.identifier)
        collectionView.register(SmallCategoryCell.self,
                                forCellWithReuseIdentifier: SmallCategoryCell.identifier)
    }

    
    // MARK: - Collection View Helper Methods -
    // In this section you can find all the layout related code
    
    /// Creates the appropriate UICollectionViewLayout for each section type
    private func makeLayout() -> UICollectionViewLayout {
        // Constructs the UICollectionViewCompositionalLayout
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch self.presenter.sectionType(for: sectionIndex) {
            case .singleList:   return self.createSingleListSection()
            case .doubleList:   return self.createDoubleListSection()
            case .tripleList:   return self.createTripleListSection()
            case .categoryList: return self.createCategoryListSection(for: self.presenter.numberOfItems(for: sectionIndex))
            }
        }
        
        // Configure the Layout with interSectionSpacing
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    
    /// Creates the layout for the Featured styled sections
    private func createSingleListSection() -> NSCollectionLayoutSection {
        // Defining the size of a single item in this layout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        // Construct the Layout Item
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Configuring the Layout Item
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        // Defining the size of a group in this layout
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                     heightDimension: .estimated(250))
        // Constructing the Layout Group
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                             subitems: [layoutItem])
        
        // Constructing the Layout Section
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        // Configuring the Layout Section
        //
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        return layoutSection
    }
    
    /// Creates a layout that shows 2 items per group and scrolls horizontally
    private func createDoubleListSection() -> NSCollectionLayoutSection {
        // Defining the size of a single item in this layout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.5))
        // Construct the Layout Item
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Configure the Layout Item
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        // Defining the size of a group in this layout
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                     heightDimension: .estimated(165))
        
        // Constructing the Layout Group
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitem: layoutItem,
                                                           count: 2)
        // Configuring the Layout Group
        layoutGroup.interItemSpacing = .fixed(8)

        // Constructing the Layout Section
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        // Configuring the Layout Section
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        // Constructing the Section Header
        let layoutSectionHeader = createSectionHeader()
        
        // Adding the Section Header to the Section Layout
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

        return layoutSection
    }
    
    /// Creates a layout that shows 3 items per group and scrolls horizontally
    private func createTripleListSection() -> NSCollectionLayoutSection {
        // Defining the size of a single item in this layout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.33))
        // Construct the Layout Item
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Configure the Layout Item
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        // Defining the size of a group in this layout
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                     heightDimension: .estimated(165))
        // Constructing the Layout Group
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitem: layoutItem,
                                                           count: 3)
        // Configuring the Layout Group
        layoutGroup.interItemSpacing = .fixed(8)
        
        // Constructing the Layout Section
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        // Configuring the Layout Section
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        // Constructing the Section Header
        let layoutSectionHeader = createSectionHeader()
        
        // Adding the Section Header to the Section Layout
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    /// Creates a layout that shows a list of small items based on the given amount.
    private func createCategoryListSection(for amount: Int) -> NSCollectionLayoutSection {
        // Defining the size of a single item in this layout
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(CGFloat(1/amount)))
        // Constructing the Layout Item
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Configuring the Layout Item
        // We use a leading of 20 here and not 5 as the other layouts because we do not use the
        // orthogonalScrollingBehavior of groupPagingCentered, which handled part of the insets.
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 5)
        
        // Defining the size of a group in this layout
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                     heightDimension: .estimated(CGFloat(40 * amount)))
        // Constructing the Layout Group
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitem: layoutItem,
                                                           count: amount)
        // Configuring the Layout Group
        layoutGroup.interItemSpacing = .fixed(8)
        
        // Constructing the Layout Section
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        // Constructing the Section header
        let layoutSectionHeader = createSectionHeader()
        
        // Adding the Section Header to the Layout Section
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        // Define size of Section Header
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                             heightDimension: .estimated(80))
        
        // Construct Section Header Layout
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                              alignment: .top)
        return layoutSectionHeader
    }
}

// MARK: - UICollectionViewDataSource -

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems(for: section)
    }
    
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
