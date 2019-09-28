//
//  OrderPackagCell.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 5/30/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class OrderPackagCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var removePackegeButton: UIButton!
    
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
    
    @IBAction func removePackegeButton(_ sender: UIButton) {
        callback?()
    }
}
