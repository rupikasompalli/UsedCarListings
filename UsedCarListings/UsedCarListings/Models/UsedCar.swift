//
//  UsedCar.swift
//  UsedCarListings
//
//  Created by Rupika Sompalli on 2022-01-21.
//

import Foundation

struct UsedCar: Codable {
    var images: UsedCarImages
    var year: Int
    var make: String
    var model: String
    var trim: String
    var listPrice: Double
    var currentPrice: Double
    var dealer: Dealer
}
