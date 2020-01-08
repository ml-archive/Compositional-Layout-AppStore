//
//  UICollectionViewCell+Identifier.swift
//  AppStore
//
//  Created by Bob De Kort on 07/01/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import UIKit

/*
 Simple extension that adds the "identifier" property to all UICollectionReusableView,
 it uses its own class name as the identifier so it should always be unique
*/

extension UICollectionReusableView {
    static var identifier: String {
        return "\(self)"
    }
}
