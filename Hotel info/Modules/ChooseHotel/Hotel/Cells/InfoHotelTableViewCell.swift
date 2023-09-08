//
//  InfoHotelTableViewCell.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 31.08.2023.
//

import UIKit

final class InfoHotelTableViewCell: UITableViewCell {
    // MARK: - UI
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .customMainBG
        view.layer.cornerRadius = 16
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayMedium, size: 22)
        label.text = Strings.aboutHotel
        return label
    }()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = SelfSizingCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(InfoHotelCollectionViewCell.self, forCellWithReuseIdentifier: CellNames.infoHotelCollectionViewCell)
        collectionView.invalidateIntrinsicContentSize()
        collectionView.layoutIfNeeded()
        return collectionView
    }()
    
    private var hotelDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Fonts.sfProDisplayRegular, size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private var buttonsView = HotelButtonsView()
    
    // MARK: - Variables
    private var peculiaritiesArray: [String] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configureCell(with model: HotelInfoModel) {
        peculiaritiesArray = model.peculiarities
        hotelDescriptionLabel.text = model.description
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate impl
extension InfoHotelTableViewCell: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource impl
extension InfoHotelTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return peculiaritiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellNames.infoHotelCollectionViewCell.self, for: indexPath) as? InfoHotelCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(with: peculiaritiesArray[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout impl
extension InfoHotelTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let content = peculiaritiesArray[indexPath.row]
        let font = UIFont.systemFont(ofSize: 16)
        let size = content.size(withAttributes: [NSAttributedString.Key.font: font])
        let paddingWidth: CGFloat = 20
        let paddingHeight: CGFloat = 1
        return CGSize(width: size.width + paddingWidth,
                      height: size.height + paddingHeight
        )
    }
}

// MARK: - private methods
private extension InfoHotelTableViewCell {
    func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        setConstraints()
    }
    
    func addSubviews() {
        contentView.myAddSubView(containerView)
        containerView.myAddSubView(titleLabel)
        containerView.myAddSubView(collectionView)
        containerView.myAddSubView(hotelDescriptionLabel)
        containerView.myAddSubView(buttonsView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 90),
            
            hotelDescriptionLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            hotelDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hotelDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            buttonsView.topAnchor.constraint(equalTo: hotelDescriptionLabel.bottomAnchor, constant: 16),
            buttonsView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            buttonsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}
