//
//  FilterViewController.swift
//  UsedCarListings
//
//  Created by Rupika Sompalli on 2022-01-21.
//

import UIKit

class FilterViewController: UIViewController {

    lazy var filterListView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FilterCell")
        return tableView
    }()
    
    private let viewModel: FilterViewModel
    
    init(viewModel: FilterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
    }
    
    private func createView() {
        self.view = filterListView
        navigationItem.title = "Preferences"
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        FilterViewModel.FilterType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        let filterType = FilterViewModel.FilterType.allCases[indexPath.row]
        cell.textLabel?.text = filterType.rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filterType = FilterViewModel.FilterType.allCases[indexPath.row]
        NotificationCenter.default.post(name: .filterSelected, object: filterType)
        navigationController?.popViewController(animated: true)
    }
}
