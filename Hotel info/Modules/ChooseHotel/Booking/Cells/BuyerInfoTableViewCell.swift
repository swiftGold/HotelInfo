//
//  BuyerInfoTableViewCell.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 05.09.2023.
//

import UIKit

final class BuyerInfoTableViewCell: UITableViewCell {
    // MARK: - UI
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customMainBG
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayMedium, size: 22)
        label.textColor = .customText
        label.text = Strings.buyerInfo
        return label
    }()
    
    private let phoneView: UIView = {
        let view = UIView()
        view.backgroundColor = .customTableViewBG
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 12)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.phoneNumber
        return label
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        textField.textColor = .customText
        textField.placeholder = Strings.phoneNUmberPlaceholder
        textField.backgroundColor = .clear
        textField.delegate = self
        return textField
    }()
    
    private let emailView: UIView = {
        let view = UIView()
        view.backgroundColor = .customTableViewBG
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 12)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.email
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        textField.textColor = .customText
        textField.placeholder = Strings.emailPlaceholder
        textField.delegate = self
        textField.backgroundColor = .clear
        return textField
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 14)
        label.textColor = .customPeculiaritiesText
        label.text = Strings.paidDescription
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Variables
    private var emailValidType: String.ValidTypes = .email
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureCell() {}
}

// MARK: -
extension BuyerInfoTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var result: Bool = false
        
        switch textField {
        case phoneTextField: result = setPhoneTextField(phoneTextField,
                                                        range: range,
                                                        replacementString: string
        )
        case emailTextField: setTextField(textField: emailTextField,
                                          validType: emailValidType,
                                          string: string,
                                          range: range
        )
        default:
            break
        }
        
        return result
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch textField {
        case phoneTextField: textFieldPhoneMask(phoneTextField)
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField: isTextFieldValid(textField: emailTextField)
        default:
            break
        }
    }
}

// MARK: - private methods
private extension BuyerInfoTableViewCell {
    func setPhoneTextField(_ textField: UITextField, range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else {
            return false
        }
        
        let newLength = currentText.count + string.count - range.length
        
        if string == "" { // Если пользователь удаляет текст
            if newLength < 6 { // Превентивное удаление префикса "+7 ("
                textField.text = "+7 ("
                return false
            }
            return true
        }
        
        if let rangeOfFirstPlaceholder = currentText.range(of: "*") {
            // Заменяем первый символ-заполнитель на введенный символ
            let newText = currentText.replacingCharacters(in: rangeOfFirstPlaceholder, with: string)
            
            // Дополнительная проверка для первого символа
            if currentText.distance(from: currentText.startIndex, to: rangeOfFirstPlaceholder.lowerBound) == 4 && string != "9" {
                return false // Первый символ может быть только 9
            }
            
            // Устанавливаем обновленный текст
            textField.text = newText
            
            // Перемещаем курсор на следующую позицию
            let newPosition = getCursorPosition(for: newText)
            if let position = textField.position(from: textField.beginningOfDocument, offset: newPosition) {
                textField.selectedTextRange = textField.textRange(from: position, to: position)
            }
        }
        
        if newLength > 18 { // Максимальная длина номера с учетом маски "+7 (XXX) XXX-XX-XX"
            return false
        }
        
        // Проверяем, что пользователь вводит только цифры
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        if !allowedCharacters.isSuperset(of: characterSet) {
            return false
        }
        
        if range.location == 3 { // после "+7 "
            textField.text = currentText + "(" + string
            return false
        } else if range.location == 7 { // после трех цифр
            textField.text = currentText + ") " + string
            return false
        } else if range.location == 11 || range.location == 14 { // после первых 3 или первых 6 цифр
            textField.text = currentText + "-" + string
            return false
        }
        return true
    }
    
    func setTextField(textField: UITextField, validType: String.ValidTypes, string: String, range: NSRange) {
        
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
    
    func textFieldPhoneMask(_ textField: UITextField) {
        if textField.text?.isEmpty == true {
            textField.text = Strings.phoneMask
            
            DispatchQueue.main.async {
                if let newPosition = textField.position(from: textField.beginningOfDocument, offset: 4) {
                    textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
                }
            }
        }
    }
    
    func isTextFieldValid(textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isValid(validType: emailValidType) {
            emailView.backgroundColor = .customTableViewBG
        } else {
            emailView.backgroundColor = .customFailedValidate
        }
    }
    
    func getCursorPosition(for text: String) -> Int {
        if let position = text.range(of: "*") {
            return text.distance(from: text.startIndex, to: position.lowerBound)
        } else {
            return text.count // Если все символы введены
        }
    }
    
    func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        contentView.myAddSubView(containerView)
        
        containerView.myAddSubView(titleLabel)
        containerView.myAddSubView(phoneView)
        containerView.myAddSubView(emailView)
        containerView.myAddSubView(descriptionLabel)
        
        phoneView.myAddSubView(phoneLabel)
        phoneView.myAddSubView(phoneTextField)
        
        emailView.myAddSubView(emailLabel)
        emailView.myAddSubView(emailTextField)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 232),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            phoneView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            phoneView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            phoneView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            phoneView.heightAnchor.constraint(equalToConstant: 52),
            
            emailView.topAnchor.constraint(equalTo: phoneView.bottomAnchor, constant: 8),
            emailView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            emailView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            emailView.heightAnchor.constraint(equalToConstant: 52),
            
            descriptionLabel.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            phoneLabel.topAnchor.constraint(equalTo: phoneView.topAnchor, constant: 10),
            phoneLabel.leadingAnchor.constraint(equalTo: phoneView.leadingAnchor, constant: 16),
            phoneLabel.trailingAnchor.constraint(equalTo: phoneView.trailingAnchor, constant: -16),
            
            phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 1),
            phoneTextField.leadingAnchor.constraint(equalTo: phoneView.leadingAnchor, constant: 16),
            phoneTextField.trailingAnchor.constraint(equalTo: phoneView.trailingAnchor, constant: -16),
            
            emailLabel.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: -16),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 1),
            emailTextField.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: -16),
        ])
    }
}
