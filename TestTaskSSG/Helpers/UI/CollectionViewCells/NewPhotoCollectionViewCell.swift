//
//  NewPhotoCollectionViewCell.swift
//  TestTaskSSG
//
//  Created by Roman Antoniuk on 03.11.2023.
//

import UIKit
import SnapKit

final class NewPhotoCollectionViewCell: BaseCollectionViewCell {
    
    lazy private var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return imageView
    }()
    
    override func resetDataUI() {
        photoImageView.image = nil
    }
    
    override func configureUI() {
        contentView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    func configureCell(with person: PersonEntity) {
        photoImageView.image = UIImage(named: person.imageName)
    }
    
}
