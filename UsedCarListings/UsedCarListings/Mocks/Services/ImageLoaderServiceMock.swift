//
//  ImageLoaderServiceMock.swift
//  UsedCarListings
//
//  Created by Rupika Sompalli on 2022-01-22.
//

import Foundation
import UIKit

class ImageLoaderServiceMock: ImageLoader {
    
    var cache: [String: UIImage] = [:]
    
    func loadImage(from url: String, completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        if let placeholder = UIImage(named: "placeholder-car") {
            self.saveImage(key: url, value: placeholder)
            completion(.success(placeholder))
        } else {
            completion(.failure(ImageLoaderError.invalidData))
        }
    }
    
    func saveImage(key: String, value: UIImage) {
        cache[key] = value
    }
}
