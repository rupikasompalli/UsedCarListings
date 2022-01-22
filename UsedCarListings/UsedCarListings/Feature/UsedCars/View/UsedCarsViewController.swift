//
//  UsedCarsViewController.swift
//  UsedCarListings
//
//  Created by Rupika Sompalli on 2022-01-21.
//

import UIKit
import Combine

class UsedCarsViewController: UIViewController {
    
    lazy var usedCarsListView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: UsedCarCell.Identifier, bundle: .main), forCellReuseIdentifier: UsedCarCell.Identifier)
        return tableView
    }()
    
    private let viewModel: UsedCarsViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: UsedCarsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        bindView()
        fetchData()
    }
    
    private func createView() {
        self.view = usedCarsListView
        navigationItem.title = "Used Car Listings"
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsClicked))
    }
    
    private func fetchData() {
        viewModel.fetchCars()
    }
    
    private func bindView() {
        viewModel
            .$listings
            .sink { [weak self] _ in
                self?.refreshView()
            }
        .store(in: &cancellables)
        
        viewModel
            .$filterType
            .sink { [weak self] _ in
                self?.refreshView()
            }
        .store(in: &cancellables)
    }
    
    private func refreshView() {
        DispatchQueue.main.async {
            self.usedCarsListView.reloadData()
        }
    }
    
    @objc func settingsClicked() {
        navigationController?.pushViewController(AppEnvironment.current.makeFilterListView(), animated: true)
    }
}

extension UsedCarsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.listings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let carCell = tableView.dequeueReusableCell(withIdentifier: UsedCarCell.Identifier, for: indexPath) as? UsedCarCell
        guard let carCell = carCell,
              let car = viewModel.listings?[indexPath.row] else {
            return UITableViewCell()
        }
        carCell.showData(car: car)
        if let carImage = viewModel.imageLoader.cache[car.images.large.first ?? ""] {
            carCell.loadCarImage(image: carImage)
        } else {
            viewModel.getCarImage(for: car) { image in
                carCell.loadCarImage(image: image)
            }
        }
        return carCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        350
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let filterType = viewModel.filterType {
            let headerView = UIView(frame: .init(x: 20, y: 0, width: tableView.frame.size.width, height: 20))
            let label = UILabel(frame: headerView.frame)
            label.text = filterType.rawValue
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            headerView.addSubview(label)
            headerView.backgroundColor = .darkGray
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let filterType = viewModel.filterType {
            return 20
        }
        return 0
    }
}
