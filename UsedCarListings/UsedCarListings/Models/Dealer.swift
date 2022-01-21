//
//  Dealer.swift
//  UsedCarListings
//
//  Created by Rupika Sompalli on 2022-01-21.
//

import Foundation

struct Dealer: Codable {
    var dealerId: String
    var name: String
    var address: String
    var phone: String
    var state: String
    var zip: String
    var avgRating: Double
    
    enum CodingKeys: String, CodingKey {
        case dealerId = "carfaxId"
        case avgRating = "dealerAverageRating"
        case name
        case address
        case phone
        case zip
        case state
    }
}
