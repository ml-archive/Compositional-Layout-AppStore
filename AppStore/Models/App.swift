//
//  App.swift
//  AppStore
//
//  Created by Bob De Kort on 06/01/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import Foundation
import UIKit

protocol SectionData { }

struct App: SectionData {
    let id: Int
    let type: String
    let name: String
    let subTitle: String
    let image: UIImage
    let hasIAP: Bool
}
