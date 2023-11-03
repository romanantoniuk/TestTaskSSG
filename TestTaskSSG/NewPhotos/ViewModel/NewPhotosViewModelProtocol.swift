//
//  NewPhotosViewModelProtocol.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 02.11.2023.
//

import Foundation

protocol NewPhotosViewModelProtocol {
    
    var items: [PersonEntity] { get }
    var filtersData: FiltersData { get }
    var isShowAgeFilters: Bool { get }

    var updateUI: ((NewPhotosViewState) -> Void)? { get set }
    
    func initial()
    func changeGenderToNext()
    func showHideAgeFilter()
    func setAgeFilter(min: Int, max: Int)
    
}
