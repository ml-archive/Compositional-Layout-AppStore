//
//  ViewController.swift
//  AppStore
//
//  Created by Bob De Kort on 06/01/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import UIKit

enum Section: Int, CaseIterable {
    case singleList
    case doubleList
//    case tripleList
//
//    case singleApp
    
    init(_ section: Int) {
        self = Section(rawValue: section)!
    }
    
    var numberOfCells: Int {
        switch self {
        case .singleList: return 3
        case .doubleList: return 6
        }
    }
    
    func app(for index: Int) -> App {
        switch self {
        case .singleList:
            return App(id: index,
                       type: "Test Type",
                       name: "Test Name \(index)",
                       subTitle: "Test subtitle \(index)",
                       image: UIImage(named: "BlueOrange")!)
        case .doubleList:
            return App(id: index+10,
                       type: "Double list",
                       name: "Double list app \(index)",
                    subTitle: "Double list app",
                image: UIImage(named: "BlueOrange")!)
        }
    }
}

class ViewController: UIViewController {
    
    // MARK: - Properties -
    private var collectionView: UICollectionView!

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Apps"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupCollectionView()
    }

    // MARK: - Setup methods -
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
        collectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: FeaturedCell.reuseIdentifier)
        collectionView.register(MediumAppCell.self, forCellWithReuseIdentifier: MediumAppCell.reuseIdentifier)
    }

    
    // MARK: - Collection View Helper Methods -
    private func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnv: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            switch Section(sectionIndex) {
            case .singleList: return self.createSingleListSection()
            case .doubleList: return self.createDoubleListSection()
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
                                                     heightDimension: .estimated(142))
        
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitem: layoutItem,
                                                           count: 2)

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
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
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Section(section).numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section(indexPath.section)
        switch section {
        case .singleList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCell.reuseIdentifier, for: indexPath) as? FeaturedCell else {
                fatalError("Could not dequeue FeatureCell")
            }
            
            cell.configure(with: section.app(for: indexPath.row))
            
            return cell
        
        case .doubleList:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediumAppCell.reuseIdentifier, for: indexPath) as? MediumAppCell else {
                fatalError("Could not dequeue MediumAppCell")
            }
            
            cell.configure(with: section.app(for: indexPath.row))
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseableIdentifier, for: indexPath) as? SectionHeader else {
            fatalError("Could not dequeue SectionHeader")
        }
        headerView.titleLabel.text = "Section header \(indexPath.section)"
        headerView.subtitleLabel.text = "Section subtitle"
        
        return headerView
    }
}
