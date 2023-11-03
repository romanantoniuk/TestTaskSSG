//
//  NewPhotosViewState.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 02.11.2023.
//

import Foundation

enum NewPhotosViewState {
    
    case initialSetup
    case reloadItems
    case updateControls(type: ControlType)
    case showHideAgeFilter

    enum ControlType {
        case gender
        case age
        case country
    }
    
}
