//
//  InfoHotelCollectionViewCell.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 31.08.2023.
//

import UIKit

final class InfoHotelCollectionViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayMedium, size: 16)
        label.textColor = .customPeculiaritiesText
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with text: String) {
        titleLabel.text = " \(text) "
    }
}

private extension InfoHotelCollectionViewCell {
    func setupCell() {
        contentView.backgroundColor = .customPeculiaritiesBG
        contentView.layer.cornerRadius = 4
        contentView.clipsToBounds = true
        contentView.myAddSubView(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
