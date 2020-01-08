//
//  AppPresenter.swift
//  AppStore
//
//  Created by Bob De Kort on 07/01/2020.
//  Copyright © 2020 Nodes. All rights reserved.
//

import UIKit

/* NOTE
 This is the minimal data layer of this ViewController.
 In a normal project depending on your architecture this would be in the Presenter,
 ViewModel, the ViewController itself or anywhere else to your liking.
 
 This will use similar methods and variables that we would use in a Presenter in the VIPER
 architecture
 */

class AppsPresenter {
    
    private var dataSource: [Section] = []
    
    init() {
        // First section: Featured
        let featuredApps = [App(id: 1, type: "GET FIT", name: "GFA", subTitle: "Generic Fitness App", image: UIImage(named: "desert")!, hasIAP: true),
                            App(id: 2, type: "SOMETHING NEW", name: "Calorie Counter App", subTitle: "Very Original concept", image: UIImage(named: "food")!, hasIAP: true),
                            App(id: 3, type: "LIFE GOALS", name: "Learn a language", subTitle: "Triolingo 5.7", image: UIImage(named: "KoreanTemple")!, hasIAP: false)]
        let section1 = Section(id: 1, type: .singleList, title: nil, subtitle: nil, data: featuredApps)
        
        dataSource.append(section1)
        
        // Second section: This weeks favorites
        let favorites = [App(id: 4, type: "Photo", name: "FilmStuff", subTitle: "Photo effects and filters", image: UIImage(named: "food")!, hasIAP: true),
                         App(id: 5, type: "Shopping", name: "Get Shopping", subTitle: "Simple grocery list", image: UIImage(named: "temple")!, hasIAP: false),
                         App(id: 6, type: "Notes", name: "White Board", subTitle: "Notes, Sketching, ...", image: UIImage(named: "desert")!, hasIAP: true),
                         App(id: 7, type: "Photo", name: "Video maker", subTitle: "Make simple videos", image: UIImage(named: "containers")!, hasIAP: true),
                         App(id: 8, type: "Shopping", name: "NaNzone", subTitle: "Buy everything here", image: UIImage(named: "temple")!, hasIAP: false),
                         App(id: 9, type: "Meditation", name: "MUtopia", subTitle: "Relax, breathe", image: UIImage(named: "oldTemple")!, hasIAP: true),
                         App(id: 10, type: "Learning", name: "Memo", subTitle: "Remind your self of your routine", image: UIImage(named: "food")!, hasIAP: false)]
        let section2 = Section(id: 2, type: .doubleList, title: "This weeks favorites", subtitle: nil, data: favorites)
        
        dataSource.append(section2)
        
        // Third section: Learn something
        let learning = [App(id: 11, type: "Learning", name: "Momi", subTitle: "Programming", image: UIImage(named: "containers")!, hasIAP: true),
                        App(id: 12, type: "Learning", name: "Tod", subTitle: "Feed your brain", image: UIImage(named: "oldTemple")!, hasIAP: false),
                        App(id: 13, type: "Learning", name: "Academy", subTitle: "Learn everything", image: UIImage(named: "food")!, hasIAP: true),
                        App(id: 14, type: "Learning", name: "Praat", subTitle: "Learn to speak", image: UIImage(named: "KoreanTemple")!, hasIAP: true),
                        App(id: 15, type: "Learning", name: "Memorable", subTitle: "Memory game", image: UIImage(named: "oldTemple")!, hasIAP: true),
                        App(id: 16, type: "Learning", name: "Mysician", subTitle: "Learn music", image: UIImage(named: "temple")!, hasIAP: true),
                        App(id: 17, type: "Learning", name: "ABE English", subTitle: "Learn englsish", image: UIImage(named: "KoreanTemple")!, hasIAP: false),
                        App(id: 18, type: "Learning", name: "Math teacher", subTitle: "quick maths!", image: UIImage(named: "food")!, hasIAP: true),
                        App(id: 19, type: "Learning", name: "TapTapRev", subTitle: "Reflexes", image: UIImage(named: "containers")!, hasIAP: true)]
        let section3 = Section(id: 3, type: .tripleList, title: "Learn something", subtitle: "Self development is key", data: learning)
        
        dataSource.append(section3)
        
        // Fourth section: Categories
        let categories = [Category(id: 1, name: "Apple watch apps", icon: UIImage(named: "desert")!),
                          Category(id: 1, name: "AR Apps", icon: UIImage(named: "temple")!),
                          Category(id: 1, name: "Photo & Video", icon: UIImage(named: "KoreanTemple")!),
                          Category(id: 1, name: "Entertainment", icon: UIImage(named: "containers")!),
                          Category(id: 1, name: "Utilities", icon: UIImage(named: "food")!)]
        let section4 = Section(id: 4, type: .categoryList, title: "Top Categories", subtitle: nil, data: categories)
        
        dataSource.append(section4)
    }
    
    // Collection View
    var numberOfSections: Int {
        return dataSource.count
    }
    
    func numberOfItems(for sectionIndex: Int) -> Int {
        let section = dataSource[sectionIndex]
        return section.data.count
    }
    
    // Cells
    func configure(item: AppConfigurable, for indexPath: IndexPath) {
        let section = dataSource[indexPath.section]
        if let app = section.data[indexPath.row] as? App {
            item.configure(with: app)
        } else {
            print("Error getting app for indexPath: \(indexPath)")
        }
    }
    
    func configure(item: CategoryConfigurable, for indexPath: IndexPath) {
        let section = dataSource[indexPath.section]
        if let category = section.data[indexPath.row] as? Category {
            item.configure(with: category)
        } else {
            print("Error getting category for indexPath: \(indexPath)")
        }
    }
    
    func sectionType(for sectionIndex: Int) -> SectionType {
        let section = dataSource[sectionIndex]
        return section.type
    }
    
    // Supplementary Views
    func title(for sectionIndex: Int) -> String? {
        let section = dataSource[sectionIndex]
        return section.title
    }
    
    func subtitle(for sectionIndex: Int) -> String? {
        let section = dataSource[sectionIndex]
        return section.subtitle
    }
}
