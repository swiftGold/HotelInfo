//
//  BookingDataTableViewCell.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 05.09.2023.
//

import UIKit

final class BookingDataTableViewCell: UITableViewCell {
    // MARK: - UI
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customMainBG
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private var flyFromFirstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.flyFrom
        return label
    }()
    
    private var flyFromSecondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customText
        label.numberOfLines = 0
        return label
    }()
    
    private let flyFromStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()
    
    private var countryCityFirstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.countryCity
        return label
    }()
    
    private var countryCitySecondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customText
        label.numberOfLines = 0
        return label
    }()
    
    private let countryCityStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()
    
    private var dateFirstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.dates
        return label
    }()
    
    private var dateSecondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customText
        label.numberOfLines = 0
        return label
    }()
    
    private let dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()
    
    private var nightsCountFirstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.numberOfNights
        return label
    }()
    
    private var nightsCountSecondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customText
        label.numberOfLines = 0
        return label
    }()
    
    private let nightsCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()
    
    private var hotelFirstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.hotel
        return label
    }()
    
    private var hotelSecondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customText
        label.text = Strings.hotelName
        label.numberOfLines = 0
        return label
    }()
    
    private let hotelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()
    
    private var appartmentFirstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.number
        return label
    }()
    
    private var appartmentSecondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customText
        label.numberOfLines = 0
        return label
    }()
    
    private let appartmentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()
    
    private var nutritionFirstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.nutrition
        return label
    }()
    
    private var nutritionSecondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customText
        label.numberOfLines = 0
        return label
    }()
    
    private let nutritionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
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
    func configureCell(with model: BookingDataModel) {
        flyFromSecondLabel.text = model.departure
        countryCitySecondLabel.text = model.arrival_country
        let startDate = model.tour_date_start
        let finishDate = model.tour_date_stop
        dateSecondLabel.text = "\(startDate) - \(finishDate)"
        let numberOfNights = model.number_of_nights.intToString()
        nightsCountSecondLabel.text = "\(numberOfNights) ночей"
        appartmentSecondLabel.text = model.room
        nutritionSecondLabel.text = model.nutrition
    }
}

// MARK: - private methods
private extension BookingDataTableViewCell {
    func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        flyFromStackView.addArrangedSubview(flyFromFirstLabel)
        flyFromStackView.addArrangedSubview(flyFromSecondLabel)
        countryCityStackView.addArrangedSubview(countryCityFirstLabel)
        countryCityStackView.addArrangedSubview(countryCitySecondLabel)
        dateStackView.addArrangedSubview(dateFirstLabel)
        dateStackView.addArrangedSubview(dateSecondLabel)
        nightsCountStackView.addArrangedSubview(nightsCountFirstLabel)
        nightsCountStackView.addArrangedSubview(nightsCountSecondLabel)
        hotelStackView.addArrangedSubview(hotelFirstLabel)
        hotelStackView.addArrangedSubview(hotelSecondLabel)
        appartmentStackView.addArrangedSubview(appartmentFirstLabel)
        appartmentStackView.addArrangedSubview(appartmentSecondLabel)
        nutritionStackView.addArrangedSubview(nutritionFirstLabel)
        nutritionStackView.addArrangedSubview(nutritionSecondLabel)

        descriptionStackView.addArrangedSubview(flyFromStackView)
        descriptionStackView.addArrangedSubview(countryCityStackView)
        descriptionStackView.addArrangedSubview(dateStackView)
        descriptionStackView.addArrangedSubview(nightsCountStackView)
        descriptionStackView.addArrangedSubview(hotelStackView)
        descriptionStackView.addArrangedSubview(appartmentStackView)
        descriptionStackView.addArrangedSubview(nutritionStackView)
        
        contentView.myAddSubView(containerView)
        
        containerView.myAddSubView(descriptionStackView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 280),
            
            descriptionStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            descriptionStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            descriptionStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            flyFromStackView.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor),
            flyFromStackView.leadingAnchor.constraint(equalTo: descriptionStackView.leadingAnchor),
            
            countryCityStackView.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor),
            countryCityStackView.leadingAnchor.constraint(equalTo: descriptionStackView.leadingAnchor),
            
            dateStackView.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor),
            dateStackView.leadingAnchor.constraint(equalTo: descriptionStackView.leadingAnchor),
            
            nightsCountStackView.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor),
            nightsCountStackView.leadingAnchor.constraint(equalTo: descriptionStackView.leadingAnchor),
            
            hotelStackView.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor),
            hotelStackView.leadingAnchor.constraint(equalTo: descriptionStackView.leadingAnchor),
            
            appartmentStackView.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor),
            appartmentStackView.leadingAnchor.constraint(equalTo: descriptionStackView.leadingAnchor),
            
            nutritionStackView.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor),
            nutritionStackView.leadingAnchor.constraint(equalTo: descriptionStackView.leadingAnchor),
            
            flyFromFirstLabel.widthAnchor.constraint(equalToConstant: Constants.firstLabelsWidth),
            countryCityFirstLabel.widthAnchor.constraint(equalToConstant: Constants.firstLabelsWidth),
            dateFirstLabel.widthAnchor.constraint(equalToConstant: Constants.firstLabelsWidth),
            nightsCountFirstLabel.widthAnchor.constraint(equalToConstant: Constants.firstLabelsWidth),
            hotelFirstLabel.widthAnchor.constraint(equalToConstant: Constants.firstLabelsWidth),
            appartmentFirstLabel.widthAnchor.constraint(equalToConstant: Constants.firstLabelsWidth),
            nutritionFirstLabel.widthAnchor.constraint(equalToConstant: Constants.firstLabelsWidth),
        ])
    }
    
    enum Constants {
      static let firstLabelsWidth: CGFloat = 140
    }
}
