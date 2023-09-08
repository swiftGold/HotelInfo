//
//  AddTouristTableViewCell.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 05.09.2023.
//

import UIKit

protocol AddTouristTableViewCellDelegate: AnyObject {
    func didTapAddTouristButton()
}

final class AddTouristTableViewCell: UITableViewCell {
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
        label.text = Strings.addTourist
        return label
    }()
    
    private lazy var upButton: UIButton = {
      let button = UIButton(type: .system)
      let image = UIImage(named: Images.plus)?.withRenderingMode(.alwaysOriginal)
      button.addTarget(self, action: #selector(didTapAddTouristButton), for: .touchUpInside)
      button.setImage(image, for: .normal)
      return button
    }()
    
    // MARK: - Variables
    weak var delegate: AddTouristTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureCell() {}
    
    // MARK: - Objc methods
    @objc
    private func didTapAddTouristButton() {
        delegate?.didTapAddTouristButton()
    }
}

// MARK: - private methods
private extension AddTouristTableViewCell {
    func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        contentView.myAddSubView(containerView)
        
        containerView.myAddSubView(titleLabel)
        containerView.myAddSubView(upButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 58),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            upButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            upButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            upButton.heightAnchor.constraint(equalToConstant: 32),
            upButton.widthAnchor.constraint(equalToConstant: 32),
        ])
    }
}

