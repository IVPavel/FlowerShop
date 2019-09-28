//
//  OrderTotalCell.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 6/18/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

class OrderTotalCell: UICollectionViewCell {
    
    @IBOutlet weak var totalPrice: UILabel!
    
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
}
