//
//  PackagCell.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 5/27/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class PackagCell: UICollectionViewCell {

    @IBOutlet weak var backgraundView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionPackag: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var imageSelect: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        style()
    }
    
    func style() {
        self.backgraundView.layer.cornerRadius = 23
    
        //shadow for cell
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 8)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
}
