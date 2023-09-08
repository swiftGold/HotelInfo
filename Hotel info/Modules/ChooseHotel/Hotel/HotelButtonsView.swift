//
//  HotelButtonsView.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 08.09.2023.
//

import UIKit

final class HotelButtonsView: UIView {
    // MARK: - UI
    private let bottomButtonsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .customPeculiaritiesBG
        return view
    }()
    // MARK: - happyView +
    private let happyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let happyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.happy)
        return imageView
    }()
    
    private let happyTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayMedium,
                            size: 16
        )
        label.text = Strings.comfort
        label.textAlignment = .left
        label.textColor = .customButtonTitle
        label.numberOfLines = 0
        return label
    }()
    
    private let happySubTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayMedium,
                            size: 14
        )
        label.text = Strings.needed
        label.textAlignment = .left
        label.textColor = .customButtonSubTitle
        label.numberOfLines = 0
        return label
    }()
    
    private let happyTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private let happyVectorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.vector)
        return imageView
    }()
    
    // MARK: - tickView +
    private let tickView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let tickImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.tick)
        return imageView
    }()
    
    private let tickTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayMedium,
                            size: 16
        )
        label.text = Strings.included
        label.textAlignment = .left
        label.textColor = .customButtonTitle
        label.numberOfLines = 0
        return label
    }()
    
    private let tickSubTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayMedium,
                            size: 14
        )
        label.text = Strings.needed
        label.textAlignment = .left
        label.textColor = .customButtonSubTitle
        label.numberOfLines = 0
        return label
    }()
    
    private let tickTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private let tickVectorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.vector)
        return imageView
    }()
    
    // MARK: - closeView +
    private let closeView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let closeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.close)
        return imageView
    }()
    
    private let closeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayMedium,
                            size: 16
        )
        label.text = Strings.nonIncluded
        label.textAlignment = .left
        label.textColor = .customButtonTitle
        label.numberOfLines = 0
        return label
    }()
    
    private let closeSubTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayMedium,
                            size: 14
        )
        label.text = Strings.needed
        label.textAlignment = .left
        label.textColor = .customButtonSubTitle
        label.numberOfLines = 0
        return label
    }()
    
    private let closeTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private let closeVectorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.vector)
        return imageView
    }()
    
    // MARK: - Buttons
    private lazy var happyButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(happyButtonTapped), for: .touchUpInside)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var tickButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(tickButtonTapped), for: .touchUpInside)
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.backgroundColor = .clear
        return button
    }()
    
    private let bottomButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private var separateView1: UIView = {
        let view = UIView()
        view.backgroundColor = .customSeparatorView
        return view
    }()
    
    private var separateView2: UIView = {
        let view = UIView()
        view.backgroundColor = .customSeparatorView
        return view
    }()
    
    // MARK: - Delegate
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Objc methods
    @objc
    private func happyButtonTapped() {
        print(#function)
    }
    
    @objc
    private func tickButtonTapped() {
        print(#function)
    }
    
    @objc
    private func closeButtonTapped() {
        print(#function)
    }
}

// MARK: - Private methods
private extension HotelButtonsView {
    func setupView() {
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        happyTitleStackView.addArrangedSubview(happyTitleLabel)
        happyTitleStackView.addArrangedSubview(happySubTitleLabel)
        
        tickTitleStackView.addArrangedSubview(tickTitleLabel)
        tickTitleStackView.addArrangedSubview(tickSubTitleLabel)
        
        closeTitleStackView.addArrangedSubview(closeTitleLabel)
        closeTitleStackView.addArrangedSubview(closeSubTitleLabel)
        
        bottomButtonsStackView.addArrangedSubview(happyButton)
        bottomButtonsStackView.addArrangedSubview(tickButton)
        bottomButtonsStackView.addArrangedSubview(closeButton)
        
        happyView.myAddSubView(happyImageView)
        happyView.myAddSubView(happyTitleStackView)
        happyView.myAddSubView(happyVectorImageView)
        tickView.myAddSubView(tickImageView)
        tickView.myAddSubView(tickTitleStackView)
        tickView.myAddSubView(tickVectorImageView)
        closeView.myAddSubView(closeImageView)
        closeView.myAddSubView(closeTitleStackView)
        closeView.myAddSubView(closeVectorImageView)
        
        myAddSubView(bottomButtonsView)
        
        bottomButtonsView.myAddSubView(happyView)
        bottomButtonsView.myAddSubView(tickView)
        bottomButtonsView.myAddSubView(closeView)
        bottomButtonsView.myAddSubView(separateView1)
        bottomButtonsView.myAddSubView(separateView2)
        bottomButtonsView.myAddSubView(bottomButtonsStackView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            bottomButtonsView.topAnchor.constraint(equalTo: topAnchor),
            bottomButtonsView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomButtonsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomButtonsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            // MARK: - happyViewConstraints
            happyView.topAnchor.constraint(equalTo: bottomButtonsView.topAnchor, constant: 15),
            happyView.leadingAnchor.constraint(equalTo: bottomButtonsView.leadingAnchor, constant: 15),
            happyView.trailingAnchor.constraint(equalTo: bottomButtonsView.trailingAnchor, constant: -15),
            happyView.heightAnchor.constraint(equalToConstant: 38),
            
            happyImageView.leadingAnchor.constraint(equalTo: happyView.leadingAnchor),
            happyImageView.centerYAnchor.constraint(equalTo: happyView.centerYAnchor),
            
            happyTitleStackView.leadingAnchor.constraint(equalTo: happyImageView.trailingAnchor, constant: 12),
            happyTitleStackView.centerYAnchor.constraint(equalTo: happyView.centerYAnchor),
            
            happyVectorImageView.trailingAnchor.constraint(equalTo: happyView.trailingAnchor, constant: -6),
            happyVectorImageView.centerYAnchor.constraint(equalTo: happyView.centerYAnchor),
            
            // MARK: - tickViewConstraints
            tickView.topAnchor.constraint(equalTo: happyView.bottomAnchor, constant: 20),
            tickView.leadingAnchor.constraint(equalTo: bottomButtonsView.leadingAnchor, constant: 15),
            tickView.trailingAnchor.constraint(equalTo: bottomButtonsView.trailingAnchor, constant: -15),
            tickView.heightAnchor.constraint(equalToConstant: 38),
            
            tickImageView.leadingAnchor.constraint(equalTo: tickView.leadingAnchor),
            tickImageView.centerYAnchor.constraint(equalTo: tickView.centerYAnchor),
            
            tickTitleStackView.leadingAnchor.constraint(equalTo: tickImageView.trailingAnchor, constant: 12),
            tickTitleStackView.centerYAnchor.constraint(equalTo: tickView.centerYAnchor),
            
            tickVectorImageView.trailingAnchor.constraint(equalTo: tickView.trailingAnchor, constant: -6),
            tickVectorImageView.centerYAnchor.constraint(equalTo: tickView.centerYAnchor),
            
            // MARK: - closeViewConstraints
            closeView.topAnchor.constraint(equalTo: tickView.bottomAnchor, constant: 20),
            closeView.bottomAnchor.constraint(equalTo: bottomButtonsView.bottomAnchor, constant: -15),
            closeView.leadingAnchor.constraint(equalTo: bottomButtonsView.leadingAnchor, constant: 15),
            closeView.trailingAnchor.constraint(equalTo: bottomButtonsView.trailingAnchor, constant: -15),
            closeView.heightAnchor.constraint(equalToConstant: 38),
            
            closeImageView.leadingAnchor.constraint(equalTo: closeView.leadingAnchor),
            closeImageView.centerYAnchor.constraint(equalTo: closeView.centerYAnchor),
            
            closeTitleStackView.leadingAnchor.constraint(equalTo: closeImageView.trailingAnchor, constant: 12),
            closeTitleStackView.centerYAnchor.constraint(equalTo: closeView.centerYAnchor),
            
            closeVectorImageView.trailingAnchor.constraint(equalTo: closeView.trailingAnchor, constant: -6),
            closeVectorImageView.centerYAnchor.constraint(equalTo: closeView.centerYAnchor),
            
            // MARK: - separatorsConstraints
            separateView1.topAnchor.constraint(equalTo: bottomButtonsView.topAnchor, constant: 63),
            separateView1.leadingAnchor.constraint(equalTo: bottomButtonsView.leadingAnchor, constant: 53),
            separateView1.trailingAnchor.constraint(equalTo: bottomButtonsView.trailingAnchor, constant: -15),
            separateView1.heightAnchor.constraint(equalToConstant: 1),
            
            separateView2.bottomAnchor.constraint(equalTo: bottomButtonsView.bottomAnchor, constant: -63),
            separateView2.leadingAnchor.constraint(equalTo: bottomButtonsView.leadingAnchor, constant: 53),
            separateView2.trailingAnchor.constraint(equalTo: bottomButtonsView.trailingAnchor, constant: -15),
            separateView2.heightAnchor.constraint(equalToConstant: 1),
            
            // MARK: - bottomButtonsConstraints
            bottomButtonsStackView.topAnchor.constraint(equalTo: bottomButtonsView.topAnchor),
            bottomButtonsStackView.bottomAnchor.constraint(equalTo: bottomButtonsView.bottomAnchor),
            bottomButtonsStackView.leadingAnchor.constraint(equalTo: bottomButtonsView.leadingAnchor),
            bottomButtonsStackView.trailingAnchor.constraint(equalTo: bottomButtonsView.trailingAnchor),
        ])
    }
}

