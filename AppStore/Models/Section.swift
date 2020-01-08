//
//  Section.swift
//  AppStore
//
//  Created by Bob De Kort on 07/01/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import Foundation

/*
The Section type will decide what layout the UICollectionView will use for that section
 */
enum SectionType: Int, CaseIterable {
    case singleList     // Featured
    case doubleList     // This weeks favorites
    case tripleList     // Learn something
    case categoryList   // Top Categories
}

// Descibes the info needed for a Section
struct Section {
    let id: Int
    let type: SectionType
    let title: String?
    let subtitle: String?
    let data: [SectionData]
}
