//
//  CellForListOfGoods.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 5/29/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class CellForListOfGoods: UICollectionViewCell {
    
    @IBOutlet weak var labelText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        style()
    }
    
    func style() {
        //design
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.7
        self.layer.masksToBounds = false
    }
}
