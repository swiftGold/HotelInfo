//
//  AboutHotelTableViewCell.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 05.09.2023.
//

import UIKit

final class AboutHotelTableViewCell: UITableViewCell {
    // MARK: - UI
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customMainBG
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.star)
        return imageView
    }()
    
    private var ratingLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.textColor = .customRatingText
        return label
    }()
    
    private var ratingDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customRatingText
        label.numberOfLines = 0
        return label
    }()
    
    private let hotelRatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 3
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.backgroundColor = .customRatingBG
        return stackView
    }()
    
    private let hotelRatingBGView: UIView = {
        let view = UIView()
        view.backgroundColor = .customRatingBG
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    private var hotelNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayMedium, size: 22)
        label.text = Strings.hotelName
        return label
    }()
    
    private var hotelAdressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customBlue
        label.font = UIFont(name: Fonts.sfProDisplayMedium, size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureCell(with model: AboutHotelModel) {
        ratingLabel.text = model.horating.intToString()
        ratingDescriptionLabel.text = model.rating_name
        hotelAdressLabel.text = model.hotel_adress
    }
}

// MARK: - private methods
private extension AboutHotelTableViewCell {
    func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        hotelRatingStackView.addArrangedSubview(starImageView)
        hotelRatingStackView.addArrangedSubview(ratingLabel)
        hotelRatingStackView.addArrangedSubview(ratingDescriptionLabel)
    
        descriptionStackView.addArrangedSubview(hotelNameLabel)
        descriptionStackView.addArrangedSubview(hotelAdressLabel)
        
        contentView.myAddSubView(containerView)
        
        containerView.myAddSubView(descriptionStackView)
        containerView.myAddSubView(hotelRatingBGView)
        hotelRatingBGView.myAddSubView(hotelRatingStackView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 120),
            
            hotelRatingBGView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            hotelRatingBGView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            hotelRatingBGView.heightAnchor.constraint(equalToConstant: 29),
            hotelRatingBGView.widthAnchor.constraint(equalToConstant: 149),
            
            descriptionStackView.topAnchor.constraint(equalTo: hotelRatingBGView.bottomAnchor, constant: 8),
            descriptionStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            descriptionStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            hotelRatingStackView.centerYAnchor.constraint(equalTo: hotelRatingBGView.centerYAnchor),
            hotelRatingStackView.centerXAnchor.constraint(equalTo: hotelRatingBGView.centerXAnchor),
        ])
    }
}
