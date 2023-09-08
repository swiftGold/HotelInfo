//
//  AppartmentTableViewCell.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 04.09.2023.
//

import UIKit

protocol AppartmentTableViewCellDelegate: AnyObject {
    func didChooseAppartmentButtonTap()
}

final class AppartmentTableViewCell: UITableViewCell {
    // MARK: - UI
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customMainBG
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: CellNames.imageCollectionViewCell)
        return collectionView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayMedium, size: 22)
        label.numberOfLines = 0
        return label
    }()
    
    private var peculiaritiesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayMedium, size: 16)
        label.textColor = .customPeculiaritiesText
        label.numberOfLines = 0
        return label
    }()
    
    private var appartmentDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .customBlue
        label.font = UIFont(name: Fonts.sfProDisplayMedium, size: 16)
        label.text = Strings.appartmentDescription
        label.numberOfLines = 0
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplaySemiBold, size: 30)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private var priceForItLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.textColor = .customPeculiaritiesText
        label.numberOfLines = 0
        return label
    }()
    
    private let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var chooseApartmentButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapchooseApartmentButton), for: .touchUpInside)
        button.setTitle(Strings.chooseRoom, for: .normal)
        button.setTitleColor(.customButtonText, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.sfProDisplayMedium, size: 16)
        button.backgroundColor = .customBigButton
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = .customTableViewBG
        pageControl.numberOfPages = 3
        pageControl.addTarget(self, action: #selector(didPickPageControl), for: .valueChanged)
        pageControl.layer.cornerRadius = 4
        pageControl.layer.masksToBounds = true
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        return pageControl
    }()
    
    // MARK: - Variables
    weak var delegate: AppartmentTableViewCellDelegate?
    private var images: [String] = []
    private var currentPage = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureCell(with model: RoomModel) {
        nameLabel.text = model.name
        peculiaritiesLabel.text = model.peculiarities.first
        let price = model.price.intToString().separate()
        priceLabel.text = "\(price) ₽"
        priceForItLabel.text = model.price_per
        images = model.image_urls
        collectionView.reloadData()
    }
    
    // MARK: - Objc methods
    @objc
    private func didTapchooseApartmentButton() {
        delegate?.didChooseAppartmentButtonTap()
    }
    
    @objc
    private func didPickPageControl(_ sender: UIPageControl) {
        let dotNumber = sender.currentPage
        if currentPage != dotNumber {
            currentPage = dotNumber
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegate impl
extension AppartmentTableViewCell: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
}

// MARK: - UICollectionViewDataSource impl
extension AppartmentTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellNames.imageCollectionViewCell, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = images[indexPath.row]
        cell.configureCell(with: model)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout impl
extension AppartmentTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

// MARK: - private methods
private extension AppartmentTableViewCell {
    func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(priceForItLabel)
        
        descriptionStackView.addArrangedSubview(nameLabel)
        descriptionStackView.addArrangedSubview(peculiaritiesLabel)
        descriptionStackView.addArrangedSubview(appartmentDescriptionLabel)
        descriptionStackView.addArrangedSubview(priceStackView)
        descriptionStackView.addArrangedSubview(chooseApartmentButton)
        
        contentView.myAddSubView(containerView)
        
        containerView.myAddSubView(collectionView)
        containerView.myAddSubView(pageControl)
        containerView.myAddSubView(descriptionStackView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 500),
            
            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -8),
            pageControl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            descriptionStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            descriptionStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            descriptionStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            chooseApartmentButton.heightAnchor.constraint(equalToConstant: 48),
            
            priceStackView.leadingAnchor.constraint(equalTo: descriptionStackView.leadingAnchor),
            priceStackView.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor),
        ])
    }
}
