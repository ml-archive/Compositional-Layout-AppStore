//
//  Section.swift
//  AppStore
//
//  Created by Bob De Kort on 07/01/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import Foundation

enum SectionType: Int, CaseIterable {
    case singleList
    case doubleList
    case tripleList
    case categoryList
    
    init(_ section: Int) {
        self = SectionType(rawValue: section)!
    }
    
    var numberOfCells: Int {
        switch self {
        case .singleList:   return 3
        case .doubleList:   return 6
        case .tripleList:   return 9
        case .categoryList: return 5
        }
    }
}

struct Section: Hashable {
    let id: Int
    let type: SectionType
    let title: String?
    let subtitle: String?
}
