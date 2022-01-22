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
    }
    
    private func refreshView() {
        DispatchQueue.main.async {
            self.usedCarsListView.reloadData()
        }
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
        if let carImage = viewModel.carImages[car.images.large.first ?? ""] {
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
}
