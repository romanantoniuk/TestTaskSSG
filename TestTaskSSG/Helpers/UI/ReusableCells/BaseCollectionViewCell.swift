//
//  BaseCollectionViewCell.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 02.11.2023.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, Reusable {

    override func prepareForReuse() {
        super.prepareForReuse()
        resetDataUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUI()
    }

    private func initUI() {
        configureUI()
        resetDataUI()
    }

    func configureUI() {}
    
    func resetDataUI() {}
    
}
