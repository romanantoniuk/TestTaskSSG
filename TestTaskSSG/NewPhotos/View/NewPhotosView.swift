//
//  NewPhotosView.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 02.11.2023.
//

import UIKit
import SnapKit

final class NewPhotosView: BaseView {
        
    // MARK: - Age slider
    lazy private (set) var containerAgeSliderView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.backgroundLight
        view.clipsToBounds = true
        if !isPhoneUI {
            view.layer.cornerRadius = 4
            view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        return view
    }()
    
    lazy private (set) var ageRangeSlider: RangeSlider = {
        let rangeSlider = RangeSlider(frame: .zero)
        rangeSlider.setBorderlineValues(min: Constants.minimumAge, max: Constants.maximumAge)
        rangeSlider.setSelectedValues(min: Constants.minimumAge, max: Constants.maximumAge)
        return rangeSlider
    }()
    
    // MARK: - CollectionView
    lazy private (set) var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CustomGridCollectionViewLayout())
        collectionView.backgroundColor = AppColor.backgroundMain
        collectionView.contentInset = .init(top: isPhoneUI ? 3 : 16, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    // MARK: - Controls button
    lazy private var controlsView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.backgroundLight
        return view
    }()
    
    lazy private var containerControlsView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.divider
        return view
    }()
    
    lazy private var controlsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        return stackView
    }()
    
    lazy private (set) var genderButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.backgroundLight
        button.titleLabel?.font = AppFonts.medium.font(with: 13)
        button.setTitleColor(AppColor.textAccent, for: .normal)
        button.centerTextAndImage(spacing: 8)
        return button
    }()
    
    lazy private (set) var ageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.backgroundLight
        button.titleLabel?.font = AppFonts.medium.font(with: 13)
        return button
    }()
    
    lazy private (set) var countryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.backgroundLight
        button.titleLabel?.font = AppFonts.medium.font(with: 13)
        button.setTitleColor(AppColor.textAccent, for: .normal)
        button.centerTextAndImage(spacing: 8)
        return button
    }()
    
    lazy private var rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    // MARK: - Setup UI
    override func configureUI() {
        // setup content views
        contentView.addSubview(rootStackView)
        rootStackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        rootStackView.addArrangedSubview(containerAgeSliderView)
        containerAgeSliderView.addSubview(ageRangeSlider)
        ageRangeSlider.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.top.equalToSuperview().inset(6)
        }
        rootStackView.addArrangedSubview(collectionView)
        // setup controls views
        contentView.addSubview(controlsView)
        controlsView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(rootStackView.snp.top)
        }
        controlsView.addSubview(containerControlsView)
        containerControlsView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(16)
        }
        containerControlsView.addSubview(controlsStackView)
        controlsStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(32)
        }
        controlsStackView.addArrangedSubview(genderButton)
        controlsStackView.addArrangedSubview(ageButton)
        controlsStackView.addArrangedSubview(countryButton)

    }
    
    // Update controls button
    func updateControlGender(with gender: PersonGender) {
        genderButton.setTitle(gender.title, for: .normal)
        genderButton.setImage(UIImage(named: gender.iconName), for: .normal)
        genderButton.setImage(UIImage(named: gender.iconName), for: .highlighted)
    }
    
    func updateControlAge(min: Int, max: Int, isActive: Bool) {
        ageButton.setTitle("\(min)-\(max)", for: .normal)
        ageButton.setTitleColor(isActive ? AppColor.textInactive : AppColor.textAccent, for: .normal)
    }
    
    func updateControlCountry(with country: PersonCountry) {
        countryButton.setTitle(country.name, for: .normal)
        countryButton.setImage(UIImage(named: country.iconName), for: .normal)
        countryButton.setImage(UIImage(named: country.iconName), for: .highlighted)
    }
    
}
