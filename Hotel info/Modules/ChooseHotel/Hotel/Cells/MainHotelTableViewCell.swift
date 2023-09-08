//
//  MainHotelTableViewCell.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 31.08.2023.
//

import UIKit

final class MainHotelTableViewCell: UITableViewCell {
    // MARK: - UI
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customMainBG
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayMedium, size: 18)
        label.text = Strings.hotel
        label.layer.shadowColor = UIColor.customText.cgColor
        label.layer.shadowOffset = CGSize(width: -2, height: 2)
        label.layer.shadowRadius = 2
        label.layer.shadowOpacity = 0.5
        label.layer.masksToBounds = false
        return label
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
        stackView.spacing = 3
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
    func configureCell(with model: HotelMainModel) {
        ratingLabel.text = model.rating.intToString()
        ratingDescriptionLabel.text = model.rating_name
        hotelAdressLabel.text = model.adress
        let price = model.minimal_price.intToString().separate()
        priceLabel.text = "от \(price) ₽"
        priceForItLabel.text = model.price_for_it.lowercased()
        images = model.images
        collectionView.reloadData()
    }
    
    // MARK: - Objc methods
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
extension MainHotelTableViewCell: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
}

// MARK: - UICollectionViewDataSource impl
extension MainHotelTableViewCell: UICollectionViewDataSource {
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
extension MainHotelTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

// MARK: - private methods
private extension MainHotelTableViewCell {
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
        
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(priceForItLabel)
        
        descriptionStackView.addArrangedSubview(hotelNameLabel)
        descriptionStackView.addArrangedSubview(hotelAdressLabel)
        descriptionStackView.addArrangedSubview(priceStackView)
        
        contentView.myAddSubView(containerView)
        contentView.myAddSubView(titleLabel)
        contentView.myAddSubView(hotelRatingBGView)
        
        containerView.myAddSubView(collectionView)
        containerView.myAddSubView(pageControl)
        containerView.myAddSubView(descriptionStackView)
        hotelRatingBGView.myAddSubView(hotelRatingStackView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 257),
            
            pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -8),
            pageControl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            hotelRatingBGView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            hotelRatingBGView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hotelRatingBGView.heightAnchor.constraint(equalToConstant: 29),
            hotelRatingBGView.widthAnchor.constraint(equalToConstant: 149),
            
            descriptionStackView.topAnchor.constraint(equalTo: hotelRatingBGView.bottomAnchor, constant: 8),
            descriptionStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            descriptionStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            descriptionStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            hotelRatingStackView.centerYAnchor.constraint(equalTo: hotelRatingBGView.centerYAnchor),
            hotelRatingStackView.centerXAnchor.constraint(equalTo: hotelRatingBGView.centerXAnchor),
            
            priceStackView.leadingAnchor.constraint(equalTo: descriptionStackView.leadingAnchor),
            priceStackView.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor),
        ])
    }
}
