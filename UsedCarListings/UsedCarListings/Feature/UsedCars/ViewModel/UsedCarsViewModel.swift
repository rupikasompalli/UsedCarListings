//
//  UsedCarsViewModel.swift
//  UsedCarListings
//
//  Created by Rupika Sompalli on 2022-01-21.
//

import Foundation
import Combine

class UsedCarsViewModel {
    
    let usedCarsService: UsedCarServiceProtocol
    let imageLoader: ImageLoader
    
    @Published var listings: [UsedCar]? = nil
    @Published var error: Error? = nil
    
    init(service: UsedCarServiceProtocol, imageLoader: ImageLoader) {
        usedCarsService = service
        self.imageLoader = imageLoader
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
    
    func getCarImage(for car: UsedCar) {
        imageLoader.loadImage(from: car.images.medium.first ?? "") { [weak self] result in
            
        }
    }
    
}
