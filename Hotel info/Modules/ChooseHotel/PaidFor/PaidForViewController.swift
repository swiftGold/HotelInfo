//
//  PaidForViewController.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 05.09.2023.
//

import UIKit

protocol PaidForRouterInput: AnyObject {
    func routeToHotelVC()
}

final class PaidForViewController: CustomVC {
    // MARK: - UI
    private let paidImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Images.paid)
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = Strings.gotToWork
        label.textColor = .customText
        label.font = UIFont(name: Fonts.sfProDisplayMedium, size: 22)
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .customPeculiaritiesText
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        return label
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .customMainBG
        view.layer.borderColor = UIColor.customBottomViewBorder.cgColor
        view.layer.borderWidth = 1.0
        return view
    }()
    
    private lazy var superButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapSuperButton), for: .touchUpInside)
        button.setTitleColor(.customButtonText, for: .normal)
        button.setTitle(Strings.superTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.sfProDisplayMedium, size: 16)
        button.backgroundColor = .customBigButton
        button.layer.cornerRadius = 15
        return button
    }()
    
    //MARK: - Variables
    var router: PaidForRouterInput?
    var viewModel = PaidForViewModel()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(titleName: Strings.paid)
        setupViewController()
        viewModel.viewDidLoad()
        bindViewModel()
    }
    
    // MARK: - Objc methods
    @objc
    private func didTapSuperButton() {
        router?.routeToHotelVC()
    }
}

// MARK: - private methods
private extension PaidForViewController {
    func bindViewModel() {
        viewModel.orderNumber.bind {[weak self] _ in
            DispatchQueue.main.async {
                guard let orderNumber = self?.viewModel.orderNumber.value else { return }
                self?.descriptionLabel.text = "Подтверждение заказа №\(orderNumber) может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление."
            }
        }
    }
    
    func nextScreenWithoutBackOnNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupViewController() {
        view.backgroundColor = .customMainBG
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.myAddSubView(paidImageView)
        view.myAddSubView(titleLabel)
        view.myAddSubView(descriptionLabel)
        view.myAddSubView(bottomView)
        bottomView.myAddSubView(superButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            paidImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -32),
            paidImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paidImageView.heightAnchor.constraint(equalToConstant: 94),
            paidImageView.widthAnchor.constraint(equalToConstant: 94),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 88),
            
            superButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 12),
            superButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            superButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            superButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}
