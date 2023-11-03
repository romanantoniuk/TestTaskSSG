//
//  Reusable.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 02.11.2023.
//

import UIKit

protocol Reusable {
    
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
    
}

extension Reusable {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib? {
        return nil
    }
    
}
