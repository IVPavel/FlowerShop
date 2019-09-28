//
//  OrderCell.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 5/27/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class OrderFlowerCell: UICollectionViewCell {

    @IBOutlet weak var flowerName: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imageFlower: UIImageView!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var removeFlowerButton: UIButton!
    
    var callback: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        style()
    }
    
    func style() {
        //radius Cell
        self.view.layer.cornerRadius = 23
        
        //shadow for cell
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        
        imageFlower.layer.cornerRadius = imageFlower.frame.size.width/2
    }
    
    //Autosize cell
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    @IBAction func removeFlowerButton(_ sender: UIButton) {
        callback?()
    }
    
}
