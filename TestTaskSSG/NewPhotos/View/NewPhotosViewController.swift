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
    
    // MARK: - State render
    private func updateState(_ state: NewPhotosViewState) {
        switch state {
        case .initialSetup:
            break
        case .reloadItems:
            break
        case .updateControls:
            break
        case .showHideAgeFilter:
            break
        }
    }
    
}
