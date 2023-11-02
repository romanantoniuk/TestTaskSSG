//
//  NewPhotosViewModel.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 02.11.2023.
//

import Foundation

final class NewPhotosViewModel: NewPhotosViewModelProtocol {
    
    var items: Set<PersonEntity> = []
    var filtersData: FiltersData = .init(gender: .any, minAge: 18, maxAge: 65)
    var isShowAgeFilters: Bool = false
    
    var updateUI: ((NewPhotosViewState) -> Void)?

    private var allItems: Set<PersonEntity> = []
    
    func initial() {
        generateItems()
        updateUI?(.initialSetup)
    }
    
    func changeGenderToNext() {
        let newGender = PersonGender.nextGender(after: filtersData.gender)
        filtersData.gender = newGender
        filterItems()
    }
    
    func showHideAgeFilter() {
        isShowAgeFilters.toggle()
        updateUI?(.updateControls)
        updateUI?(.showHideAgeFilter)
    }
    
    func setAgeFilter(min: Int, max: Int) {
        filtersData.minAge = min
        filtersData.maxAge = max
        filterItems()
        updateUI?(.updateControls)
    }
    
    private func filterItems() {
        items = allItems.filter { person in
            let genderMatches = filtersData.gender == .any || person.gender == filtersData.gender
            let ageInRange = person.age >= filtersData.minAge && person.age <= min(filtersData.maxAge, 65)
            return genderMatches && ageInRange
        }
        updateUI?(.reloadItems)
    }
    
    // helpers functions
    private func generateItems() {
        (0..<10).forEach { number in
            let age = Int.random(in: 18..<66)
            let man = PersonEntity(imageName: "man\(number)", age: age, gender: .man)
            allItems.insert(man)
            let woman = PersonEntity(imageName: "woman\(number)", age: age, gender: .woman)
            allItems.insert(woman)
        }
    }
    
}
