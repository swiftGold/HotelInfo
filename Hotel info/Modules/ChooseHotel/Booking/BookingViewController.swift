//
//  BookingViewController.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 05.09.2023.
//

import UIKit

protocol BookingRouterInput: AnyObject {
    func routeToPaidVC()
}

final class BookingViewController: CustomVC {
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(AboutHotelTableViewCell.self,
                           forCellReuseIdentifier: CellNames.aboutHotelTableViewCell
        )
        tableView.register(BookingDataTableViewCell.self,
                           forCellReuseIdentifier: CellNames.bookingDataTableViewCell
        )
        tableView.register(BuyerInfoTableViewCell.self,
                           forCellReuseIdentifier: CellNames.buyerInfoTableViewCell
        )
        tableView.register(TouristTableViewCell.self,
                           forCellReuseIdentifier: CellNames.touristTableViewCell
        )
        tableView.register(AddTouristTableViewCell.self,
                           forCellReuseIdentifier: CellNames.addTouristTableViewCell
        )
        tableView.register(FinalPriceTableViewCell.self,
                           forCellReuseIdentifier: CellNames.finalPriceTableViewCell
        )
        tableView.backgroundColor = .customTableViewBG
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.customBottomViewBorder.cgColor
        view.layer.borderWidth = 1.0
        view.backgroundColor = .customMainBG
        return view
    }()
    
    private lazy var chooseApartmentButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapchooseApartmentButton), for: .touchUpInside)
        button.setTitleColor(.customButtonText, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.sfProDisplayMedium, size: 16)
        button.backgroundColor = .customBigButton
        button.layer.cornerRadius = 15
        return button
    }()
    
    //MARK: - Variables
    var router: BookingRouterInput?
    var viewModel = BookingViewModel(apiService: APIService(networkManager: NetworkManager(jsonService: JSONDecoderManager())))
    private var bookingSectionModels: [BookingSectionModel] = []
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(titleName: Strings.booking)
        setupViewController()
        viewModel.viewDidLoad()
        bindViewModel()
        addTaps()
        notificationsSetup()
    }
    
    // MARK: - DeInit
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Objc methods
    @objc
    private func didTapchooseApartmentButton() {
        var hasEmptyFields = false
        
        for case let cell as TouristTableViewCell in tableView.visibleCells {
            if cell.checkEmptyTextFields() {
                hasEmptyFields = true
            }
        }
        
        if !hasEmptyFields {
            router?.routeToPaidVC()
        }
    }
    
    @objc
    private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size ?? CGSize.zero
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height + 80, right: 0.0)
        
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    @objc
    private func keyboardWillHide(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
}

// MARK: - UITableViewDelegate impl
extension BookingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

// MARK: - UITableViewDataSource impl
extension BookingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return bookingSectionModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookingSectionModels[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let section = indexPath.section
        let rowType = bookingSectionModels[section].rows[row]
        
        switch rowType {
        case .aboutHotel(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.aboutHotelTableViewCell.self, for: indexPath) as? AboutHotelTableViewCell else {
                fatalError()
            }
            cell.configureCell(with: model)
            return cell
        case .bookingData(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.bookingDataTableViewCell.self, for: indexPath) as? BookingDataTableViewCell else {
                fatalError()
            }
            cell.configureCell(with: model)
            return cell
        case .buyerInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.buyerInfoTableViewCell.self, for: indexPath) as? BuyerInfoTableViewCell else {
                fatalError()
            }
            return cell
        case .tourist(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.touristTableViewCell.self, for: indexPath) as? TouristTableViewCell else {
                fatalError()
            }
            let index = indexPath.row
            cell.configureCell(with: model[index])
            cell.delegate = self
            return cell
        case .addTourist:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.addTouristTableViewCell.self, for: indexPath) as? AddTouristTableViewCell else {
                fatalError()
            }
            cell.delegate = self
            return cell
        case .finalPrice(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.finalPriceTableViewCell.self, for: indexPath) as? FinalPriceTableViewCell else {
                fatalError()
            }
            cell.configureCell(with: model)
            return cell
        }
    }
}

// MARK: - TouristTableViewCellDelegate impl
extension BookingViewController: TouristTableViewCellDelegate {
    func didTapArrowButton() {
        tableView.beginUpdates()
        let currentOffset = tableView.contentOffset
        tableView.reloadData()
        tableView.layoutIfNeeded()
        tableView.contentOffset = currentOffset
        tableView.endUpdates()
    }
}

// MARK: - AddTouristTableViewCellDelegate impl
extension BookingViewController: AddTouristTableViewCellDelegate {
    func didTapAddTouristButton() {
        viewModel.addTourist()
    }
}

// MARK: - private methods
private extension BookingViewController {
    func notificationsSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func addTaps() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapScreen)
    }
    
    func bindViewModel() {
        viewModel.sectionModels.bind { [weak self] _ in
            DispatchQueue.main.async {
                guard let response = self?.viewModel.sectionModels.value else { return }
                self?.bookingSectionModels = response
                self?.tableView.reloadData()
            }
        }
        
        viewModel.sumFromModel.bind { [weak self] _ in
            DispatchQueue.main.async {
                guard let sum = self?.viewModel.sumFromModel.value else { return }
                self?.chooseApartmentButton.setTitle("\(sum) ₽", for: .normal)
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
        view.myAddSubView(tableView)
        view.myAddSubView(bottomView)
        bottomView.myAddSubView(chooseApartmentButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 88),
            
            chooseApartmentButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 12),
            chooseApartmentButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16),
            chooseApartmentButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16),
            chooseApartmentButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}
