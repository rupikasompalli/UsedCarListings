//
//  UsedCarService.swift
//  UsedCarListings
//
//  Created by Rupika Sompalli on 2022-01-21.
//

import Foundation

protocol UsedCarServiceProtocol {
    typealias UsedCarServiceResult = ((Result<[UsedCar], Error>) -> Void)
    func fetchUsedCars(completion: @escaping UsedCarServiceResult)
}

class UsedCarServiceBackend: UsedCarServiceProtocol {
    func fetchUsedCars(completion: @escaping UsedCarServiceResult) {
        let endpoint = "https://carfax-for-consumers.firebaseio.com/assignment.json"
        guard let url = URL(string: endpoint) else {
            debugPrint("Cannot create fetch used car url")
            return
        }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let carListings = try JSONDecoder().decode(UsedCarListings.self, from: data)
                    completion(.success(carListings.listings))
                }
                if let error = error {
                    completion(.failure(error))
                }
            } catch {
                debugPrint("Cannot parse codable model", error)
                completion(.failure(error))
            }
        }.resume()
    }
}
