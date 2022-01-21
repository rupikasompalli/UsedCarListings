//
//  UsedCarCell.swift
//  UsedCarListings
//
//  Created by Rupika Sompalli on 2022-01-21.
//

import UIKit

class UsedCarCell: UITableViewCell {
    
    @IBOutlet weak var ymmLabel: UILabel!
    @IBOutlet weak var trimLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var mileageLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var contentHolder: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customizeView()
    }

    func customizeView() {
        
    }
    
    func showData(car: UsedCar) {
        ymmLabel.text = "\(car.year) \(car.make) \(car.model)"
        trimLabel.text = 
    }
}
