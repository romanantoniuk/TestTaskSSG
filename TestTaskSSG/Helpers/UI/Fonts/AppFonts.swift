//
//  AppFonts.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 02.11.2023.
//

import UIKit
import CoreText

enum AppFonts: String {
    
    case medium = "Roboto-Medium"

    private var defaultWeight: UIFont.Weight {
        switch self {
        case .medium:
            return .medium
        }
    }
    
    func font(with size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size, weight: defaultWeight)
    }
    
}
