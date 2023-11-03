//
//  PersonGender.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 02.11.2023.
//

import Foundation

enum PersonGender: CaseIterable {
    
    case any
    case man
    case woman
    
    var title: String {
        switch self {
        case .any:
            return "Any"
        case .man:
            return "Male"
        case .woman:
            return "Female"
        }
    }
    
    var iconName: String {
        switch self {
        case .any:
            return "GenderAny"
        case .man:
            return "GenderMale"
        case .woman:
            return "GenderFemale"
        }
    }
    
    static func nextGender(after currentGender: PersonGender) -> PersonGender {
        guard let currentIndex = PersonGender.allCases.firstIndex(of: currentGender) else {
            return .any
        }
        let nextIndex = (currentIndex + 1) % PersonGender.allCases.count
        return PersonGender.allCases[nextIndex]
    }
    
}
