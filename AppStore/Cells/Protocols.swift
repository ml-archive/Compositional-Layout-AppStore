//
//  Protocols.swift
//  AppStore
//
//  Created by Bob De Kort on 07/01/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import Foundation

protocol AppConfigurable {
    func configure(with app: App)
}

protocol CategoryConfigurable {
    func configure(with category: Category)
}
