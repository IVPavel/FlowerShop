//
//  CollectionViewCell.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 5/16/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var getImageURL = String()
    
    @IBOutlet weak var nameFlower: UILabel!
    @IBOutlet weak var imageFlower: UIImageView!
    @IBOutlet weak var deskriptionFlower: UILabel!
    @IBOutlet weak var priceFlower: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var viewLayer: UIView!
    
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
        
        //rounding the edges of the cells
        self.viewLayer.layer.cornerRadius = 23
        
        //rounded image
        self.imageFlower?.layer.cornerRadius = self.imageFlower.frame.size.width / 2
    }
    
    @IBAction func likeButton(_ sender: UIButton) {  } 
}
