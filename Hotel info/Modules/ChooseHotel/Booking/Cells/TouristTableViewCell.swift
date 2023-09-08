//
//  TouristTableViewCell.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 05.09.2023.
//

import UIKit

protocol TouristTableViewCellDelegate: AnyObject {
    func didTapArrowButton()
}

final class TouristTableViewCell: UITableViewCell {
    // MARK: - UI
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customMainBG
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let bottomContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayMedium, size: 22)
        label.textColor = .customText
        return label
    }()
    
    private lazy var arrowButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: Images.up)?.withRenderingMode(.alwaysOriginal)
        button.addTarget(self, action: #selector(didTapUpButton), for: .touchUpInside)
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let firstNameView: UIView = {
        let view = UIView()
        view.backgroundColor = .customTableViewBG
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private let firstNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 12)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.name
        return label
    }()
    
    private lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        textField.textColor = .customText
        textField.placeholder = Strings.namePlaceholder
        textField.delegate = self
        textField.backgroundColor = .clear
        return textField
    }()
    
    private let secondNameView: UIView = {
        let view = UIView()
        view.backgroundColor = .customTableViewBG
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private let secondNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 12)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.surname
        return label
    }()
    
    private lazy var secondNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        textField.textColor = .customText
        textField.placeholder = Strings.surnamePlaceholder
        textField.delegate = self
        textField.backgroundColor = .clear
        return textField
    }()
    
    private let birthsdayView: UIView = {
        let view = UIView()
        view.backgroundColor = .customTableViewBG
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var birthsdayTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: Fonts.sfProDisplayRegular, size: 17)
        textField.textColor = .customText
        textField.placeholder = Strings.birthsday
        textField.delegate = self
        textField.backgroundColor = .clear
        return textField
    }()
    
    private let citizenView: UIView = {
        let view = UIView()
        view.backgroundColor = .customTableViewBG
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var citizenTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: Fonts.sfProDisplayRegular, size: 17)
        textField.textColor = .customText
        textField.placeholder = Strings.citizen
        textField.delegate = self
        textField.backgroundColor = .clear
        return textField
    }()
    
    private let passportNumberView: UIView = {
        let view = UIView()
        view.backgroundColor = .customTableViewBG
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var passportNumberTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: Fonts.sfProDisplayRegular, size: 17)
        textField.textColor = .customText
        textField.placeholder = Strings.passportNumber
        textField.delegate = self
        textField.backgroundColor = .clear
        return textField
    }()
    
    private let passportValidityView: UIView = {
        let view = UIView()
        view.backgroundColor = .customTableViewBG
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var passportValidityTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: Fonts.sfProDisplayRegular, size: 17)
        textField.textColor = .customText
        textField.placeholder = Strings.passportValidity
        textField.delegate = self
        textField.backgroundColor = .clear
        return textField
    }()
    
    // MARK: - Variables
    private var collapsedConstraint: NSLayoutConstraint?
    private var expandedConstraint: NSLayoutConstraint?
    private var isTapped = true
    private var nameValidType: String.ValidTypes = .name
    private var numbersValidType: String.ValidTypes = .numbers
    weak var delegate: TouristTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureCell(with model: TouristNumber) {
        titleLabel.text = model.stringNumber
    }
    
    func checkEmptyTextFields() -> Bool {
        let isEmptyName = firstNameTextField.text?.isEmpty ?? true
        let isEmptySurname = secondNameTextField.text?.isEmpty ?? true
        let isEmptyBirthsday = birthsdayTextField.text?.isEmpty ?? true
        let isEmptyCitizen = citizenTextField.text?.isEmpty ?? true
        let isEmptyPassportNumber = passportNumberTextField.text?.isEmpty ?? true
        let isEmptyPassportValidity = passportValidityTextField.text?.isEmpty ?? true
        
        firstNameView.backgroundColor = isEmptyName ? .customFailedValidate : .customTableViewBG
        secondNameView.backgroundColor = isEmptySurname ? .customFailedValidate : .customTableViewBG
        birthsdayView.backgroundColor = isEmptyBirthsday ? .customFailedValidate : .customTableViewBG
        citizenView.backgroundColor = isEmptyCitizen ? .customFailedValidate : .customTableViewBG
        passportNumberView.backgroundColor = isEmptyPassportNumber ? .customFailedValidate : .customTableViewBG
        passportValidityView.backgroundColor = isEmptyPassportValidity ? .customFailedValidate : .customTableViewBG
        
        return isEmptyName || isEmptySurname || isEmptyBirthsday || isEmptyCitizen || isEmptyPassportNumber || isEmptyPassportValidity
    }
    
    // MARK: - Objc methods
    @objc
    private func didTapUpButton() {
        updateAppearance()
        delegate?.didTapArrowButton()
    }
}

// MARK: -
extension TouristTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case firstNameTextField:
            setTextField(textField: firstNameTextField,
                         validType: nameValidType,
                         string: string,
                         range: range
            )
        case secondNameTextField:
            setTextField(textField: secondNameTextField,
                         validType: nameValidType,
                         string: string,
                         range: range
            )
        case birthsdayTextField:
            setTextField(textField: birthsdayTextField,
                         validType: numbersValidType,
                         string: string,
                         range: range
            )
        case citizenTextField:
            setTextField(textField: citizenTextField,
                         validType: nameValidType,
                         string: string,
                         range: range
            )
        case passportNumberTextField:
            setTextField(textField: passportNumberTextField,
                         validType: numbersValidType,
                         string: string,
                         range: range
            )
        case passportValidityTextField:
            setTextField(textField: passportValidityTextField,
                         validType: numbersValidType,
                         string: string,
                         range: range
            )
        default:
            break
        }
        
        return false
    }
}

// MARK: - private methods
private extension TouristTableViewCell {
    func setTextField(textField: UITextField, validType: String.ValidTypes, string: String, range: NSRange) {
        
        if string.isValid(validType: validType) {
            let text = (textField.text ?? "") + string
            let result: String
            
            if range.length == 1 {
                let end = text.index(text.startIndex, offsetBy: text.count - 1)
                result = String(text[text.startIndex..<end])
            } else {
                result = text
            }
            
            textField.text = result
        }
    }
    
    func updateAppearance() {
        bottomContainerView.setNeedsLayout()
        bottomContainerView.layoutIfNeeded()
        isTapped = !isTapped
        if isTapped {
            expandedConstraint?.isActive = true
            collapsedConstraint?.isActive = false
            arrowButton.setImage(UIImage(named: Images.up), for: .normal)
        } else {
            expandedConstraint?.isActive = false
            collapsedConstraint?.isActive = true
            arrowButton.setImage(UIImage(named: Images.down), for: .normal)
        }
        bottomContainerView.setNeedsLayout()
        bottomContainerView.layoutIfNeeded()
    }
    
    func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        
        let tapGesture = UITapGestureRecognizer()
        bottomContainerView.addGestureRecognizer(tapGesture)
        
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        contentView.myAddSubView(containerView)
        containerView.myAddSubView(topContainerView)
        containerView.myAddSubView(bottomContainerView)
        
        topContainerView.myAddSubView(titleLabel)
        topContainerView.myAddSubView(arrowButton)
        bottomContainerView.myAddSubView(firstNameView)
        bottomContainerView.myAddSubView(secondNameView)
        bottomContainerView.myAddSubView(birthsdayView)
        bottomContainerView.myAddSubView(citizenView)
        bottomContainerView.myAddSubView(passportNumberView)
        bottomContainerView.myAddSubView(passportValidityView)
        
        firstNameView.myAddSubView(firstNameLabel)
        firstNameView.myAddSubView(firstNameTextField)
        
        secondNameView.myAddSubView(secondNameLabel)
        secondNameView.myAddSubView(secondNameTextField)
        
        birthsdayView.myAddSubView(birthsdayTextField)
        citizenView.myAddSubView(citizenTextField)
        passportNumberView.myAddSubView(passportNumberTextField)
        passportValidityView.myAddSubView(passportValidityTextField)
    }
    
    func setConstraints() {
        collapsedConstraint = bottomContainerView.heightAnchor.constraint(equalToConstant: 0)
        collapsedConstraint?.priority = .defaultLow
        collapsedConstraint?.isActive = false
        
        expandedConstraint = bottomContainerView.heightAnchor.constraint(equalToConstant: 380)
        expandedConstraint?.priority = .defaultLow
        expandedConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            topContainerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            topContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            topContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            topContainerView.heightAnchor.constraint(equalToConstant: 58),
            
            bottomContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor),
            bottomContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bottomContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bottomContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            
            titleLabel.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -16),
            
            arrowButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -16),
            arrowButton.heightAnchor.constraint(equalToConstant: 32),
            arrowButton.widthAnchor.constraint(equalToConstant: 32),
            
            firstNameView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 20),
            firstNameView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 16),
            firstNameView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -16),
            firstNameView.heightAnchor.constraint(equalToConstant: 52),
            
            secondNameView.topAnchor.constraint(equalTo: firstNameView.bottomAnchor, constant: 8),
            secondNameView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 16),
            secondNameView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -16),
            secondNameView.heightAnchor.constraint(equalToConstant: 52),
            
            birthsdayView.topAnchor.constraint(equalTo: secondNameView.bottomAnchor, constant: 8),
            birthsdayView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 16),
            birthsdayView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -16),
            birthsdayView.heightAnchor.constraint(equalToConstant: 52),
            
            citizenView.topAnchor.constraint(equalTo: birthsdayView.bottomAnchor, constant: 8),
            citizenView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 16),
            citizenView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -16),
            citizenView.heightAnchor.constraint(equalToConstant: 52),
            
            passportNumberView.topAnchor.constraint(equalTo: citizenView.bottomAnchor, constant: 8),
            passportNumberView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 16),
            passportNumberView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -16),
            passportNumberView.heightAnchor.constraint(equalToConstant: 52),
            
            passportValidityView.topAnchor.constraint(equalTo: passportNumberView.bottomAnchor, constant: 8),
            passportValidityView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor, constant: 16),
            passportValidityView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor, constant: -16),
            passportValidityView.heightAnchor.constraint(equalToConstant: 52),
            
            firstNameLabel.topAnchor.constraint(equalTo: firstNameView.topAnchor, constant: 10),
            firstNameLabel.leadingAnchor.constraint(equalTo: firstNameView.leadingAnchor, constant: 16),
            firstNameLabel.trailingAnchor.constraint(equalTo: firstNameView.trailingAnchor, constant: -16),
            
            firstNameTextField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 1),
            firstNameTextField.leadingAnchor.constraint(equalTo: firstNameView.leadingAnchor, constant: 16),
            firstNameTextField.trailingAnchor.constraint(equalTo: firstNameView.trailingAnchor, constant: -16),
            
            secondNameLabel.topAnchor.constraint(equalTo: secondNameView.topAnchor, constant: 10),
            secondNameLabel.leadingAnchor.constraint(equalTo: secondNameView.leadingAnchor, constant: 16),
            secondNameLabel.trailingAnchor.constraint(equalTo: secondNameView.trailingAnchor, constant: -16),
            
            secondNameTextField.topAnchor.constraint(equalTo: secondNameLabel.bottomAnchor, constant: 1),
            secondNameTextField.leadingAnchor.constraint(equalTo: secondNameView.leadingAnchor, constant: 16),
            secondNameTextField.trailingAnchor.constraint(equalTo: secondNameView.trailingAnchor, constant: -16),
            
            birthsdayTextField.centerYAnchor.constraint(equalTo: birthsdayView.centerYAnchor),
            birthsdayTextField.leadingAnchor.constraint(equalTo: birthsdayView.leadingAnchor, constant: 16),
            birthsdayTextField.trailingAnchor.constraint(equalTo: birthsdayView.trailingAnchor, constant: -16),
            
            citizenTextField.centerYAnchor.constraint(equalTo: citizenView.centerYAnchor),
            citizenTextField.leadingAnchor.constraint(equalTo: citizenView.leadingAnchor, constant: 16),
            citizenTextField.trailingAnchor.constraint(equalTo: citizenView.trailingAnchor, constant: -16),
            
            passportNumberTextField.centerYAnchor.constraint(equalTo: passportNumberView.centerYAnchor),
            passportNumberTextField.leadingAnchor.constraint(equalTo: passportNumberView.leadingAnchor, constant: 16),
            passportNumberTextField.trailingAnchor.constraint(equalTo: passportNumberView.trailingAnchor, constant: -16),
            
            passportValidityTextField.centerYAnchor.constraint(equalTo: passportValidityView.centerYAnchor),
            passportValidityTextField.leadingAnchor.constraint(equalTo: passportValidityView.leadingAnchor, constant: 16),
            passportValidityTextField.trailingAnchor.constraint(equalTo: passportValidityView.trailingAnchor, constant: -16),
        ])
    }
}
