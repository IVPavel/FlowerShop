//
//  CellForReviewItem.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 5/29/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class CellForReviewItem: UICollectionViewCell {
    
    @IBOutlet weak var imageFlower: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        
        style()
    }
    
    func style() {
        //design
        imageFlower.layer.cornerRadius = imageFlower.frame.size.width/2
        
        self.layer.cornerRadius = 23
        
        //shadow
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.7
        self.layer.masksToBounds = false
    }
}
