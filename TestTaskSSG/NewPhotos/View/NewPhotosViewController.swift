//
//  NewPhotosViewController.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 02.11.2023.
//

import UIKit

final class NewPhotosViewController: UIViewController {
    
    private(set) var rootView = NewPhotosView()
    var viewModel: NewPhotosViewModelProtocol
    
    // MARK: - Controller life
    required init(vm: NewPhotosViewModelProtocol) {
        self.viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    // MARK: - Setup
    private func setupVC() {
        rootView.titleLabel.text = "New photos"
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        rootView.collectionView.registerReusableCell(NewPhotoCollectionViewCell.self)

        rootView.genderButton.addTarget(self, action: #selector(tapChangeGender), for: .touchUpInside)
        rootView.ageButton.addTarget(self, action: #selector(tapShowAgeFilter), for: .touchUpInside)
        rootView.ageRangeSlider.addTarget(self, action: #selector(changeAgeSlider(_:)), for: .valueChanged)
        
        viewModel.updateUI = { [weak self] in self?.updateState($0) }
        viewModel.initial()
    }
    
    // MARK: - Actions
    @objc func tapChangeGender() {
        viewModel.changeGenderToNext()
    }
    
    @objc func tapShowAgeFilter() {
        viewModel.showHideAgeFilter()
    }
    
    @objc func changeAgeSlider(_ slider: RangeSlider) {
        viewModel.setAgeFilter(min: slider.lowerValue, max: slider.upperValue)
    }
    
    // MARK: - State render
    private func updateState(_ state: NewPhotosViewState) {
        switch state {
        case .initialSetup:
            let filtersData = viewModel.filtersData
            rootView.updateControlGender(with: filtersData.gender)
            rootView.updateControlAge(min: filtersData.minAge, max: filtersData.maxAge, isActive: viewModel.isShowAgeFilters)
            rootView.ageRangeSlider.setSelectedValues(min: filtersData.minAge, max: filtersData.maxAge)
            rootView.containerAgeSliderView.isHidden = !viewModel.isShowAgeFilters
            rootView.updateControlCountry(with: filtersData.country)
            rootView.collectionView.reloadData()
        case .reloadItems:
            UIView.transition(with: rootView.collectionView, duration: 0.3, options: .transitionCrossDissolve, animations: {[weak self] in
                guard let self = self else { return }
                self.rootView.collectionView.reloadData()
            }, completion: nil)
        case .updateControls(let type):
            let filtersData = viewModel.filtersData
            switch type {
            case .gender:
                rootView.updateControlGender(with: filtersData.gender)
            case .age:
                rootView.updateControlAge(min: filtersData.minAge, max: filtersData.maxAge, isActive: viewModel.isShowAgeFilters)
            case .country:
                rootView.updateControlCountry(with: filtersData.country)
            }
            if rootView.collectionView.numberOfItems(inSection: 0) > 0 {
                let indexPath = IndexPath(item: 0, section: 0)
                rootView.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            }
        case .showHideAgeFilter:
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self = self else { return }
                self.rootView.containerAgeSliderView.isHidden = !self.viewModel.isShowAgeFilters
            }
        }
    }
    
}

extension NewPhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewPhotoCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.configureCell(with: viewModel.items[indexPath.row])
        return cell
    }
    
}

extension NewPhotosViewController: UICollectionViewDelegateCustomGridLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, numberOfColumnsInSection section: Int) -> Int {
        let width = collectionView.bounds.width
        let numbersOfColumns = Int(width) / (traitCollection.horizontalSizeClass == .compact ? 123 : 168)
        return numbersOfColumns
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numbersOfColumns = Int(width) / (traitCollection.horizontalSizeClass == .compact ? 123 : 168)
        let widthCell = (collectionView.bounds.width - (CGFloat(numbersOfColumns) - 1) * 3) / CGFloat(numbersOfColumns)
        if let image = UIImage(named: viewModel.items[indexPath.row].imageName) {
            let width = image.size.width
            let height = image.size.height
            let aspectRatio =  height / width
            return  .init(width: widthCell, height: widthCell * aspectRatio)
        } else {
            return .init(width: widthCell, height: widthCell)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumColumnSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumIntervalItemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
}
