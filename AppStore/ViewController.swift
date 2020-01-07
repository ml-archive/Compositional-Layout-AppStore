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
        collectionView = UICollectionView.init(frame: .zero,
                                               collectionViewLayout: makeLayout())
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.reuseableIdentifier)
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
    
    private func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch self.presenter.sectionType(for: sectionIndex) {
            case .singleList:   return self.createSingleListSection()
            case .doubleList:   return self.createDoubleListSection()
            case .tripleList:   return self.createTripleListSection()
            case .categoryList: return self.createCategoryListSection(for: self.presenter.numberOfItems(for: sectionIndex))
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    private func createSingleListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                     heightDimension: .estimated(250))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                             subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        return layoutSection
    }
    
    private func createDoubleListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.5))

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                     heightDimension: .estimated(165))
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitem: layoutItem,
                                                           count: 2)
        layoutGroup.interItemSpacing = .fixed(8)

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

        return layoutSection
    }
    
    private func createTripleListSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.33))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                     heightDimension: .estimated(165))
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitem: layoutItem,
                                                           count: 3)
        layoutGroup.interItemSpacing = .fixed(8)
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    private func createCategoryListSection(for amount: Int) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(CGFloat(1/amount)))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                     heightDimension: .estimated(CGFloat(40 * amount)))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitem: layoutItem,
                                                           count: amount)
        layoutGroup.interItemSpacing = .fixed(8)
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        let layoutSectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
        
        return layoutSection
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95),
                                                             heightDimension: .estimated(80))
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
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseableIdentifier, for: indexPath) as? SectionHeader else {
            fatalError("Could not dequeue SectionHeader")
        }
        
        if let title = presenter.title(for: indexPath.section) {
            headerView.titleLabel.text = title
            headerView.titleLabel.isHidden = false
        } else {
            headerView.titleLabel.isHidden = true
        }
        
        if let subtitle = presenter.subtitle(for: indexPath.section) {
            headerView.subtitleLabel.text = subtitle
            headerView.subtitleLabel.isHidden = false
        } else {
            headerView.subtitleLabel.isHidden = true
        }
        
        return headerView
    }
}
