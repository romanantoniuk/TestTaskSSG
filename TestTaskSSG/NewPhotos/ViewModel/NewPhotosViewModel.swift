//
//  NewPhotosViewModel.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 02.11.2023.
//

import Foundation

final class NewPhotosViewModel: NewPhotosViewModelProtocol {
    
    var items: [PersonEntity] = []
    var filtersData: FiltersData = .init(gender: .any,
                                         minAge: Constants.minimumAge,
                                         maxAge: Constants.maximumAge,
                                         country: .init(iconName: "Azerbaijan",
                                                        name: "Azerbaijan"))
    var isShowAgeFilters: Bool = false
    
    var updateUI: ((NewPhotosViewState) -> Void)?

    private var allItems: [PersonEntity] = []
    
    func initial() {
        generateItems()
        updateUI?(.initialSetup)
    }
    
    func changeGenderToNext() {
        let newGender = PersonGender.nextGender(after: filtersData.gender)
        filtersData.gender = newGender
        updateUI?(.updateControls(type: .gender))
        filterItems()
    }
    
    func showHideAgeFilter() {
        isShowAgeFilters.toggle()
        updateUI?(.updateControls(type: .age))
        updateUI?(.showHideAgeFilter)
    }
    
    func setAgeFilter(min: Int, max: Int) {
        filtersData.minAge = min
        filtersData.maxAge = max
        filterItems()
        updateUI?(.updateControls(type: .age))
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
        (0..<20).forEach { number in
            let randomValueForChangeOrder = Int.random(in: 0..<99999)
            let age = Int.random(in: 19..<66)
            let man = PersonEntity(imageName: "man\(number)", age: age, gender: .man, randomValueForChangeOrder: randomValueForChangeOrder)
            allItems.append(man)
            let woman = PersonEntity(imageName: "woman\(number)", age: age, gender: .woman, randomValueForChangeOrder: randomValueForChangeOrder)
            allItems.append(woman)
        }
        allItems.sort(by: {$0.randomValueForChangeOrder < $1.randomValueForChangeOrder})
        items = allItems
    }
    
}
