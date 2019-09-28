//
//  designSlider.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 5/25/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableSlider: UISlider {

    @IBInspectable var thumbImage: UIImage? {
        didSet {
            setThumbImage(thumbImage, for: .normal)
        }
    }
    
    @IBInspectable var thumbHighlightedImege: UIImage? {
        didSet {
            setThumbImage(thumbHighlightedImege, for: .highlighted)
        }
    }
}
