//
//  FilterViewModel.swift
//  UsedCarListings
//
//  Created by Rupika Sompalli on 2022-01-21.
//

import Foundation

class FilterViewModel {
    enum FilterType: String, CaseIterable {
        case price = "Filter By Price"
        case mileage = "Filter By Mileage"
    }
}
