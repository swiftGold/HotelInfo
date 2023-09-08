//
//  FinalPriceTableViewCell.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 05.09.2023.
//

import UIKit

final class FinalPriceTableViewCell: UITableViewCell {
    // MARK: - UI
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customMainBG
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private var tourPriceFirstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.tour
        return label
    }()
    
    private var tourPriceSecondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customText
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private let tourPriceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()
    
    private var fuelFirstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.fuel
        return label
    }()
    
    private var fuelSecondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customText
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private let fuelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()
    
    private var serviceFirstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.service
        return label
    }()
    
    private var serviceSecondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customText
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private let serviceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()
    
    private var finalPriceFirstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.toPaid
        return label
    }()
    
    private var finalPriceSecondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplaySemiBold, size: 16)
        label.textColor = .customBlue
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private let finalPriceStackView: UIStackView = {
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
    func configureCell(with model: FinalPriceModel) {
        let tourPrice = model.tour_price.intToString().separate()
        let fuel = model.fuel_charge.intToString().separate()
        let service = model.service_charge.intToString().separate()
        let finalPrice = (model.tour_price + model.fuel_charge + model.service_charge).intToString().separate()

        tourPriceSecondLabel.text = "\(tourPrice) ₽"
        fuelSecondLabel.text = "\(fuel) ₽"
        serviceSecondLabel.text = "\(service) ₽"
        finalPriceSecondLabel.text = "\(finalPrice) ₽"
    }
}

// MARK: - private methods
private extension FinalPriceTableViewCell {
    func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        tourPriceStackView.addArrangedSubview(tourPriceFirstLabel)
        tourPriceStackView.addArrangedSubview(tourPriceSecondLabel)
        fuelStackView.addArrangedSubview(fuelFirstLabel)
        fuelStackView.addArrangedSubview(fuelSecondLabel)
        serviceStackView.addArrangedSubview(serviceFirstLabel)
        serviceStackView.addArrangedSubview(serviceSecondLabel)
        finalPriceStackView.addArrangedSubview(finalPriceFirstLabel)
        finalPriceStackView.addArrangedSubview(finalPriceSecondLabel)

        descriptionStackView.addArrangedSubview(tourPriceStackView)
        descriptionStackView.addArrangedSubview(fuelStackView)
        descriptionStackView.addArrangedSubview(serviceStackView)
        descriptionStackView.addArrangedSubview(finalPriceStackView)
        
        contentView.myAddSubView(containerView)
        
        containerView.myAddSubView(descriptionStackView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 156),
            
            descriptionStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            descriptionStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            descriptionStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
        ])
    }
}
