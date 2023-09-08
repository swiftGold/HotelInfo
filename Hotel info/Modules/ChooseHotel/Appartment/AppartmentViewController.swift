//
//  AppartmentViewController.swift
//  Hotel info
//
//  Created by Сергей Золотухин on 04.09.2023.
//

import UIKit

protocol AppartmentRouterInput: AnyObject {
    func routeToBookingVC()
}

final class AppartmentViewController: CustomVC {
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(AppartmentTableViewCell.self,
                           forCellReuseIdentifier: CellNames.appartmentTableViewCell
        )
        tableView.backgroundColor = .customTableViewBG
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - Variables
    var router: AppartmentRouterInput?
    var viewModel = AppartmentViewModel(apiService: APIService(networkManager: NetworkManager(jsonService: JSONDecoderManager())))
    var models: [RoomModel] = []
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar(titleName: Strings.hotelName)
        setupViewController()
        viewModel.viewDidLoad()
        bindViewModel()
    }
}

// MARK: - UITableViewDelegate impl
extension AppartmentViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource impl
extension AppartmentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.appartmentTableViewCell.self, for: indexPath) as? AppartmentTableViewCell else {
            fatalError()
        }
        cell.delegate = self
        let model = models[indexPath.row]
        cell.configureCell(with: model)
        return cell
    }
}

// MARK: - AppartmentTableViewCellDelegate impl
extension AppartmentViewController: AppartmentTableViewCellDelegate {
    func didChooseAppartmentButtonTap() {
        router?.routeToBookingVC()
    }
}

// MARK: - private methods
private extension AppartmentViewController {
    func bindViewModel() {
        viewModel.responseModel.bind { [weak self] _ in
            DispatchQueue.main.async {
                guard let response = self?.viewModel.responseModel.value?.rooms else { return }
                self?.models = response
                self?.tableView.reloadData()
            }
        }
    }
    
    func setupViewController() {
        view.backgroundColor = .customMainBG
        
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        view.myAddSubView(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

