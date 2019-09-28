//
//  TopCVCell.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 6/9/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class TopCVCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        style()
    }
    
    func style() {
        //shadow for cell
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        
        //rounding image
        self.image.layer.cornerRadius = 23
    }

}
