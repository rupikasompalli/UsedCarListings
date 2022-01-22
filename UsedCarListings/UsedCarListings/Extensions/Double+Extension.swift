//
//  Double+Extension.swift
//  UsedCarListings
//
//  Created by Rupika Sompalli on 2022-01-21.
//

import Foundation

extension Double {
    var asLocaleCurrency: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: .init(value: self))
    }
}
