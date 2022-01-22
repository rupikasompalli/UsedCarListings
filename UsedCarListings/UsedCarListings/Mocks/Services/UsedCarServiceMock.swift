//
//  UsedCarServiceMock.swift
//  UsedCarListings
//
//  Created by Rupika Sompalli on 2022-01-22.
//

import Foundation

struct UsedCarServiceMock: UsedCarServiceProtocol {
    func fetchUsedCars(completion: @escaping UsedCarServiceResult) {
        let url = Bundle.main.url(forResource: "UsedCars", withExtension: "json")
        guard let url = url else {
            print("no json url")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let listings = try decoder.decode(UsedCarListings.self, from: data)
            completion(.success(listings.listings))
        } catch  {
            debugPrint("error", error)
            completion(.failure(error))
        }
    }
}
