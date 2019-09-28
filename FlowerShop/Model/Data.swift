//
//  Data.swift
//  FlowerShop
//
//  Created by Pavel Ivanov on 6/18/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//

import Foundation

struct OrderFlower {
    var image = String()
    var name = String()
    var price = Int()
    var size = String()
    var quantity = Int()
}

struct OrderPackeg {
    var name: String
    var description: String
    var image: String
    var price: Int
}

class TotalPrice {
    static var shared = TotalPrice()
    
    var fullPrice = Int()
    var orderArray = [Any]()
    
    private init() {
    }
}
