//
//  BaseView.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 02.11.2023.
//

import UIKit
import SnapKit

class BaseView: UIView {
    
    private (set) var isPhoneUI: Bool = false
    
    lazy private (set) var contentView = UIView()

    lazy private var headerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    lazy private var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background_nav_bar_image")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy private (set) var titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.medium.font(with: 21)
        label.textColor = AppColor.textLight
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    private func setupViews() {
        backgroundColor = AppColor.backgroundMain
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            isPhoneUI = true
        case .pad, .tv, .carPlay, .mac, .vision, .unspecified:
            isPhoneUI = false
        @unknown default:
            isPhoneUI = false
        }
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            if isPhoneUI {
                make.bottom.leading.trailing.equalTo(safeAreaLayoutGuide)
                make.top.equalTo(safeAreaLayoutGuide).inset(48)
            } else {
                make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(85)
                make.bottom.equalTo(safeAreaLayoutGuide)
                make.top.equalTo(safeAreaLayoutGuide).inset(88)
            }
            
        }
        addSubview(headerView)
        headerView.snp.makeConstraints { make in
            if isPhoneUI {
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview()
            } else {
                make.top.equalTo(safeAreaLayoutGuide).inset(40)
                make.leading.trailing.equalTo(contentView)
            }
            make.bottom.equalTo(contentView.snp.top)

        }
        headerView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
        }
        if !isPhoneUI {
            headerView.layer.cornerRadius = 4
            headerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            if isPhoneUI {
                make.top.equalTo(safeAreaLayoutGuide)
            } else {
                make.top.equalTo(safeAreaLayoutGuide).inset(40)
            }
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    // for override
    func configureUI() { }

}
