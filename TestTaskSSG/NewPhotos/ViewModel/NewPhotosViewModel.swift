//
//  NewPhotosViewModel.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 02.11.2023.
//

import Foundation

final class NewPhotosViewModel: NewPhotosViewModelProtocol {
    
    var updateUI: ((NewPhotosViewState) -> Void)?

    func initial() {
        updateUI?(.initialSetup)
    }
    
}
