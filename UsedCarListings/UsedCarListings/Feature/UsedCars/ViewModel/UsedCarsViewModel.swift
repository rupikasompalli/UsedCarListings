//
//  UsedCarsViewModel.swift
//  UsedCarListings
//
//  Created by Rupika Sompalli on 2022-01-21.
//

import Foundation
import Combine
import UIKit

class UsedCarsViewModel {
    
    let usedCarsService: UsedCarServiceProtocol
    let imageLoader: ImageLoader
    
    @Published var listings: [UsedCar]? = nil
    @Published var error: Error? = nil
    @Published var filterType: FilterViewModel.FilterType? = nil
    
    var cancelSet: Set<AnyCancellable> = []
    var carImages: [String: UIImage] = [:]
    var downloadRequests: [String] = []
    
    init(service: UsedCarServiceProtocol, imageLoader: ImageLoader) {
        usedCarsService = service
        self.imageLoader = imageLoader
        
        NotificationCenter.default.publisher(for: .filterSelected)
                    .compactMap{ $0.object as? FilterViewModel.FilterType }
                    .sink() {
                        [weak self] type in
                        self?.filterType = type
                        self?.performFiltering()
                    }
                    .store(in: &cancelSet)
    }
    
    private func performFiltering() {
        if let type = filterType {
            switch type {
            case .price:
                self.listings = self.listings?.sorted { $0.listPrice < $1.listPrice }
            case .mileage:
                self.listings = self.listings?.sorted { $0.mileage < $1.mileage }
            }
        }
    }
    
    func fetchCars() {
        usedCarsService.fetchUsedCars { result in
            switch result {
            case .success(let data):
                self.listings = data
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func getCarImage(for car: UsedCar, completion: @escaping ((UIImage) -> Void)) {
        let url = car.images.large.first ?? ""
        if !downloadRequests.contains(url) {
            imageLoader.loadImage(from: url) { [weak self] result in
                switch result {
                case .success(let image):
                    self?.carImages[url] = image
                    self?.downloadRequests.removeAll { $0 == url }
                    completion(image)
                case .failure(let error):
                    debugPrint("Error in downloadin image", error)
                }
            }
            downloadRequests.append(url)
        }
    }
}
