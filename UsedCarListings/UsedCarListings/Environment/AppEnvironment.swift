//
//  AppEnvironment.swift
//  UsedCarListings
//
//  Created by Rupika Sompalli on 2022-01-21.
//

import Foundation

protocol Environment {
    var usedCarService: UsedCarServiceProtocol { get }
    var imageLoaderService: ImageLoader { get }
}

protocol AppFactory {
    func makeUsedCarsView() -> UsedCarsViewController
}

struct AppEnvironment: Environment {
    static let current = AppEnvironment()
    
    var usedCarService: UsedCarServiceProtocol {
        return UsedCarServiceBackend()
    }
    
    var imageLoaderService: ImageLoader {
        ImageLoaderService()
    }
}

extension AppEnvironment: AppFactory {
    func makeUsedCarsView() -> UsedCarsViewController {
        let vm = UsedCarsViewModel(service: usedCarService, imageLoader: imageLoaderService)
        let view = UsedCarsViewController(viewModel: vm)
        return view
    }
    
    func makeFilterListView() -> FilterViewController {
        let vm = FilterViewModel()
        let view = FilterViewController(viewModel: vm)
        return view
    }
}
