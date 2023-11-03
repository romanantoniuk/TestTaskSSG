//
//  FlowTabBarItem.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 03.11.2023.
//

import UIKit

enum FlowTabBarItem: Int, CaseIterable {
    
    case Profile = 0
    case Search = 1
    case VideoChat = 2
    case Messages = 3
    case Gallery = 4
    case Favorites = 5
    
    var icon: UIImage? {
        get {
            switch self {
            case .Profile:
                return UIImage(named: "Menu-Profile")
            case .Search:
                return UIImage(named: "Menu-Search")
            case .VideoChat:
                return UIImage(named: "Menu-VideoChat")
            case .Messages:
                return UIImage(named: "Menu-Messages")
            case .Gallery:
                return UIImage(named: "Menu-Gallery")
            case .Favorites:
                return UIImage(named: "Menu-Favorites")
            }
        }
    }
    
}
