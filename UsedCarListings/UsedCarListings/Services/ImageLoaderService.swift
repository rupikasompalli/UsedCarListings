//
//  ImageLoaderService.swift
//  UsedCarListings
//
//  Created by Rupika Sompalli on 2022-01-21.
//

import Foundation
import UIKit

protocol ImageLoader {
    var cache: [String: UIImage] { get }
    func loadImage(from url: String, completion: @escaping ((Result<UIImage, Error>)-> Void))
    func saveImage(key: String, value: UIImage)
}

enum ImageLoaderError: Error {
    case invalidData
}

class ImageLoaderService: ImageLoader {
    
    var cache: [String: UIImage] = [:]
    
    func loadImage(from url: String, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        if let cachedImage = cache[url] {
            completion(.success(cachedImage))
            return
        }
        guard let imgUrl = URL(string: url) else {
            return
        }
        URLSession.shared.dataTask(with: imgUrl) { [weak self] data, response, error in
            guard let self = self else { return }
            if let data = data {
                if let img = UIImage(data: data) {
                    self.saveImage(key: url, value: img)
                    completion(.success(img))
                } else {
                    completion(.failure(ImageLoaderError.invalidData))
                }
            }
            if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func saveImage(key: String, value: UIImage) {
        cache[key] = value
    }
}
