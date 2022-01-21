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
    @Published var carImages: [String: UIImage] = [:]
    
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
        let url = car.images.large.first ?? ""
        imageLoader.loadImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.carImages[url] = image
            case .failure(let error):
                debugPrint("Error in downloadin image", error)
            }
        }
    }
    
}
