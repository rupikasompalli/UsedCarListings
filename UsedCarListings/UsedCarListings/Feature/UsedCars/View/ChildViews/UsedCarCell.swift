//
//  UsedCarCell.swift
//  UsedCarListings
//
//  Created by Rupika Sompalli on 2022-01-21.
//

import UIKit

class UsedCarCell: UITableViewCell {
    
    static let Identifier = "UsedCarCell"
    
    @IBOutlet weak var ymmLabel: UILabel!
    @IBOutlet weak var trimLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mileageLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var contentHolder: UIView!
    
    var usedCar: UsedCar?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customizeView()
    }

    func customizeView() {
        imageView?.contentMode = .scaleAspectFit
    }
    
    func showData(car: UsedCar) {
        self.usedCar = car
        DispatchQueue.main.async { [weak self] in
            self?.ymmLabel.text = "\(car.year) \(car.make) \(car.model)"
            self?.trimLabel.text = car.trim
            self?.priceLabel.text = car.listPrice.asLocaleCurrency
            self?.mileageLabel.text = "\(car.mileage)"
            self?.addressLabel.text = car.dealer.address
        }
    }
    
    func loadCarImage(image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            if image.size.width == 1 {
                // No image found, load placeholder
                self?.carImageView.image = UIImage(named: "placeholder-car")
            } else {
                self?.carImageView.image = image
            }
        }
    }
    
    @IBAction func callDealer() {
        guard let car = usedCar else {
            return
        }
        if let url = URL(string: "tel://\(car.dealer.phone)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            debugPrint("Cannot make a phone call")
        }
    }
}
