//
//  HotelViewController.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 31.08.2023.
//

import UIKit

protocol HotelRouterInput: AnyObject {
    func routeToAppartmentVC()
}

final class HotelViewController: UIViewController {
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MainHotelTableViewCell.self,
                           forCellReuseIdentifier: CellNames.mainHotelTableViewCell
        )
        tableView.register(InfoHotelTableViewCell.self,
                           forCellReuseIdentifier: CellNames.infoHotelTableViewCell
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
        button.setTitle(Strings.chooseAppartment, for: .normal)
        button.setTitleColor(.customButtonText, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.sfProDisplayMedium, size: 16)
        button.backgroundColor = .customBigButton
        button.layer.cornerRadius = 15
        return button
    }()
    
    //MARK: - Variables
    var router: HotelRouterInput?
    var viewModel = HotelViewModel(apiService: APIService(networkManager: NetworkManager(jsonService: JSONDecoderManager())))
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        nextScreenWithoutBackOnNavBar()
        setupViewController()
        viewModel.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Objc methods
    @objc
    private func didTapchooseApartmentButton() {
        router?.routeToAppartmentVC()
    }
}

// MARK: - UITableViewDelegate impl
extension HotelViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource impl
extension HotelViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionModels.value.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionModels.value[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let section = indexPath.section
        let rowType = viewModel.sectionModels.value[section].rows[row]
        
        switch rowType {
        case .hotelMain(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.mainHotelTableViewCell.self, for: indexPath) as? MainHotelTableViewCell else {
                fatalError()
            }
            cell.configureCell(with: model)
            return cell
        case .hotelInfo(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.infoHotelTableViewCell.self, for: indexPath) as? InfoHotelTableViewCell else {
                fatalError()
            }
            cell.configureCell(with: model)
            return cell
        }
    }
}

// MARK: - private methods
private extension HotelViewController {
    func bindViewModel() {
        viewModel.sectionModels.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
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
