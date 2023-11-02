//
//  NewPhotosViewModelProtocol.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 02.11.2023.
//

import Foundation

protocol NewPhotosViewModelProtocol {
    
    var updateUI: ((NewPhotosViewState) -> Void)? { get set }
    
    func initial()
    
}
